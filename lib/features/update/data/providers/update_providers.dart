import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';
import 'package:salat_tracker/features/update/update.dart';
import 'package:salat_tracker/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

part 'update_providers.g.dart';

const _graceDeadlineKey = 'update_grace_deadline_epoch';
const _lastRequiredBlockedKey = 'update_last_required_blocked';
const _minSupportedVersionKey = 'update_last_min_supported_version';
const _updateCheckCooldownKey = 'update_last_check_epoch';

@riverpod
UpdateRepository updateRepository(Ref ref) => UpdateRepository();

@riverpod
InstallSourceService installSourceService(Ref ref) => InstallSourceService();

@riverpod
ApkUpdateInstaller apkUpdateInstaller(Ref ref) => ApkUpdateInstaller();

@riverpod
PlayUpdateService playUpdateService(Ref ref) => PlayUpdateService();

@riverpod
UpdatePolicyEngine updatePolicyEngine(Ref ref) => const UpdatePolicyEngine();

@riverpod
Box<int> updateMetaBox(Ref ref) => Hive.box<int>(HiveService.updateMetaBoxName);

@Riverpod(keepAlive: true)
class UpdateNotifier extends _$UpdateNotifier {
  bool _inFlight = false;

  @override
  Future<UpdateDecision> build() async {
    final l10n = S.current;
    unawaited(checkForUpdates());
    return UpdateDecision(
      status: UpdateStatus.idle,
      action: UpdateAction.check,
      message: l10n.updateTapToCheck,
    );
  }

  Future<void> checkForUpdates() async {
    if (_inFlight) {
      return;
    }

    final now = DateTime.now();
    if (_isWithinCooldown(now)) {
      return;
    }

    _inFlight = true;

    final l10n = S.current;
    state = AsyncData(
      UpdateDecision(
        status: UpdateStatus.checking,
        action: UpdateAction.none,
        message: l10n.generalLoading,
      ),
    );

    try {
      final channel = await ref
          .read(installSourceServiceProvider)
          .detectChannel();
      if (channel == UpdateChannel.play) {
        final hasUpdate = await ref
            .read(playUpdateServiceProvider)
            .checkForUpdate();
        if (hasUpdate) {
          state = AsyncData(
            UpdateDecision(
              status: UpdateStatus.available,
              action: UpdateAction.updateNow,
              message: l10n.updateAvailable,
            ),
          );
          return;
        }

        state = AsyncData(
          UpdateDecision(
            status: UpdateStatus.upToDate,
            action: UpdateAction.check,
            message: l10n.updateUpToDate,
          ),
        );
        await _clearGraceDeadline();
        await _setLastRequiredBlocked(false);
        await _setMinSupportedVersion(0);
        return;
      }

      final manifest = await ref.read(updateRepositoryProvider).fetchManifest();
      final currentCode = await ref
          .read(installSourceServiceProvider)
          .currentVersionCode();
      final graceDeadline = _readGraceDeadline();
      final availableUrl =
          channel == UpdateChannel.github && manifest.sha256 != null
          ? manifest.apkUrl
          : manifest.storeUrl;
      final decision = ref
          .read(updatePolicyEngineProvider)
          .evaluate(
            currentVersionCode: currentCode,
            manifest: manifest,
            now: now,
            graceDeadline: graceDeadline,
            noUpdateMessage: l10n.updateUpToDate,
            availableMessage: l10n.updateAvailable,
            requiredMessage: l10n.updateRequiredGrace,
            blockedMessage: l10n.updateRequiredBlocked,
          )
          .copyWith(
            downloadUrl: availableUrl,
            storeUrl: manifest.storeUrl,
            sha256: manifest.sha256,
          );

      if (decision.graceDeadline != null && graceDeadline == null) {
        await _writeGraceDeadline(decision.graceDeadline!);
      }

      if (decision.status == UpdateStatus.upToDate) {
        await _clearGraceDeadline();
        await _setLastRequiredBlocked(false);
        await _setMinSupportedVersion(0);
      }

      if (decision.status == UpdateStatus.requiredBlocked) {
        await _setLastRequiredBlocked(true);
        await _setMinSupportedVersion(manifest.minSupportedVersionCode);
      }

      if (decision.status == UpdateStatus.requiredGrace) {
        await _setLastRequiredBlocked(false);
        await _setMinSupportedVersion(manifest.minSupportedVersionCode);
      }

      state = AsyncData(decision);
      await _setLastCheck(now);
    } on Object {
      final lastBlocked = _isLastRequiredBlocked();
      final currentCode = await ref
          .read(installSourceServiceProvider)
          .currentVersionCode();
      final minSupported = _readMinSupportedVersion();
      if (lastBlocked && minSupported > 0 && currentCode < minSupported) {
        state = AsyncData(
          UpdateDecision(
            status: UpdateStatus.requiredBlocked,
            action: UpdateAction.updateNow,
            message: l10n.updateRequiredBlocked,
            error: UpdateError.network,
            storeUrl: AppConstants.playStoreUrl,
          ),
        );
        return;
      }

      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateCheckFailed,
          error: UpdateError.network,
        ),
      );
      await _setLastCheck(now);
    } finally {
      _inFlight = false;
    }
  }

  Future<void> performPrimaryAction() async {
    final current = state.value;
    if (current == null) {
      await checkForUpdates();
      return;
    }

    switch (current.action) {
      case UpdateAction.check:
      case UpdateAction.retry:
        await _clearLastCheck();
        await checkForUpdates();
      case UpdateAction.updateNow:
        await _performPlayUpdateOrStore(
          current.storeUrl ?? current.downloadUrl,
        );
      case UpdateAction.downloadAndInstall:
        await _downloadAndInstall(current.downloadUrl);
      case UpdateAction.install:
        if (current.installPath != null) {
          await _installPath(current.installPath!);
        }
      case UpdateAction.openSettings:
      case UpdateAction.none:
        break;
    }
  }

  Future<void> _performPlayUpdateOrStore(String? url) async {
    final l10n = S.current;
    try {
      final channel = await ref
          .read(installSourceServiceProvider)
          .detectChannel();
      if (channel == UpdateChannel.play) {
        await ref.read(playUpdateServiceProvider).performImmediateUpdate();
        return;
      }

      if (url == null || url.isEmpty) {
        state = AsyncData(
          UpdateDecision(
            status: UpdateStatus.error,
            action: UpdateAction.retry,
            message: l10n.updateInstallFailed,
            error: UpdateError.updateUrlInvalid,
          ),
        );
        return;
      }
      final launched = await launchUrl(Uri.parse(url));
      if (!launched) {
        state = AsyncData(
          UpdateDecision(
            status: UpdateStatus.error,
            action: UpdateAction.retry,
            message: l10n.updateInstallFailed,
            error: UpdateError.updateUrlInvalid,
          ),
        );
        return;
      }
    } on Object {
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateInstallFailed,
          error: UpdateError.playUpdateFailed,
        ),
      );
    }
  }

  Future<void> _downloadAndInstall(String? url) async {
    final l10n = S.current;
    final currentDecision = state.value;
    final expectedSha256 = currentDecision?.sha256;
    final channel = await ref
        .read(installSourceServiceProvider)
        .detectChannel();

    if (channel == UpdateChannel.play) {
      await _performPlayUpdateOrStore(url);
      return;
    }

    if (url == null || url.isEmpty) {
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateDownloadFailed,
          error: UpdateError.updateUrlInvalid,
        ),
      );
      return;
    }

    final parsedUrl = Uri.tryParse(url);
    final isHttps = parsedUrl != null && parsedUrl.scheme == 'https';
    if (!isHttps) {
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateDownloadFailed,
          error: UpdateError.updateUrlInvalid,
        ),
      );
      return;
    }

    state = AsyncData(
      UpdateDecision(
        status: UpdateStatus.downloading,
        action: UpdateAction.none,
        message: l10n.updateDownloading,
        downloadUrl: url,
        sha256: expectedSha256,
      ),
    );

    try {
      final path = await ref
          .read(apkUpdateInstallerProvider)
          .downloadLatestApk(url, sha256: expectedSha256);
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.readyToInstall,
          action: UpdateAction.install,
          message: l10n.updateReadyToInstall,
          installPath: path,
          downloadUrl: url,
          sha256: expectedSha256,
        ),
      );
      await _installPath(path);
    } on ApkUpdateInstallerException catch (e) {
      final error = switch (e.error) {
        ApkUpdateInstallerError.checksumMissing => UpdateError.checksumMissing,
        ApkUpdateInstallerError.checksumMismatch =>
          UpdateError.checksumMismatch,
        ApkUpdateInstallerError.downloadFailed => UpdateError.downloadFailed,
        ApkUpdateInstallerError.installerLaunchFailed =>
          UpdateError.installerLaunchFailed,
      };

      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateDownloadFailed,
          error: error,
        ),
      );
    } on Object {
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateDownloadFailed,
          error: UpdateError.downloadFailed,
        ),
      );
    }
  }

  Future<void> _installPath(String path) async {
    final l10n = S.current;
    try {
      await ref.read(apkUpdateInstallerProvider).installFromPath(path);
    } on Object {
      state = AsyncData(
        UpdateDecision(
          status: UpdateStatus.error,
          action: UpdateAction.retry,
          message: l10n.updateInstallFailed,
          installPath: path,
          error: UpdateError.installerLaunchFailed,
        ),
      );
    }
  }

  DateTime? _readGraceDeadline() {
    final epoch = _readMetaInt(_graceDeadlineKey);
    if (epoch == null || epoch <= 0) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(epoch, isUtc: true).toLocal();
  }

  Future<void> _writeGraceDeadline(DateTime deadline) async {
    await _writeMetaInt(
      _graceDeadlineKey,
      deadline.toUtc().millisecondsSinceEpoch,
    );
  }

  Future<void> _clearGraceDeadline() async {
    await _deleteMetaKey(_graceDeadlineKey);
  }

  bool _isLastRequiredBlocked() {
    return (_readMetaInt(_lastRequiredBlockedKey) ?? 0) == 1;
  }

  Future<void> _setLastRequiredBlocked(bool value) async {
    await _writeMetaInt(_lastRequiredBlockedKey, value ? 1 : 0);
  }

  int _readMinSupportedVersion() {
    return _readMetaInt(_minSupportedVersionKey) ?? 0;
  }

  Future<void> _setMinSupportedVersion(int value) async {
    await _writeMetaInt(_minSupportedVersionKey, value);
  }

  bool _isWithinCooldown(DateTime now) {
    final epoch = _readMetaInt(_updateCheckCooldownKey);
    if (epoch == null || epoch <= 0) {
      return false;
    }
    final last = DateTime.fromMillisecondsSinceEpoch(
      epoch,
      isUtc: true,
    ).toLocal();
    return now.difference(last) < const Duration(minutes: 10);
  }

  Future<void> _setLastCheck(DateTime now) async {
    await _writeMetaInt(
      _updateCheckCooldownKey,
      now.toUtc().millisecondsSinceEpoch,
    );
  }

  Future<void> _clearLastCheck() async {
    await _deleteMetaKey(_updateCheckCooldownKey);
  }

  int? _readMetaInt(String key) {
    try {
      final box = ref.read(updateMetaBoxProvider);
      return box.get(key);
    } on Object {
      return null;
    }
  }

  Future<void> _writeMetaInt(String key, int value) async {
    try {
      final box = ref.read(updateMetaBoxProvider);
      await box.put(key, value);
    } on Object {
      // Ignore persistence errors for non-critical metadata in tests/startup.
    }
  }

  Future<void> _deleteMetaKey(String key) async {
    try {
      final box = ref.read(updateMetaBoxProvider);
      await box.delete(key);
    } on Object {
      // Ignore persistence errors for non-critical metadata in tests/startup.
    }
  }
}
