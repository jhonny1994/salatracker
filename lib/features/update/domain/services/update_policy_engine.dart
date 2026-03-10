import 'package:salat_tracker/features/update/update.dart';

class UpdatePolicyEngine {
  const UpdatePolicyEngine();

  UpdateDecision evaluate({
    required int currentVersionCode,
    required UpdateManifest manifest,
    required DateTime now,
    required String noUpdateMessage,
    required String availableMessage,
    required String requiredMessage,
    required String blockedMessage,
    DateTime? graceDeadline,
  }) {
    if (currentVersionCode >= manifest.latestVersionCode) {
      return UpdateDecision(
        status: UpdateStatus.upToDate,
        action: UpdateAction.check,
        message: noUpdateMessage,
      );
    }

    if (currentVersionCode < manifest.minSupportedVersionCode) {
      final effectiveDeadline =
          graceDeadline ?? now.add(Duration(hours: manifest.graceHours));
      if (now.isAfter(effectiveDeadline)) {
        return UpdateDecision(
          status: UpdateStatus.requiredBlocked,
          action: UpdateAction.downloadAndInstall,
          message: blockedMessage,
          graceDeadline: effectiveDeadline,
          downloadUrl: manifest.apkUrl,
        );
      }

      return UpdateDecision(
        status: UpdateStatus.requiredGrace,
        action: UpdateAction.downloadAndInstall,
        message: requiredMessage,
        graceDeadline: effectiveDeadline,
        downloadUrl: manifest.apkUrl,
      );
    }

    return UpdateDecision(
      status: UpdateStatus.available,
      action: UpdateAction.downloadAndInstall,
      message: availableMessage,
      downloadUrl: manifest.apkUrl,
    );
  }
}
