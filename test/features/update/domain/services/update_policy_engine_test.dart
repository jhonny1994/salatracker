import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/update/update.dart';

void main() {
  group('UpdatePolicyEngine', () {
    const engine = UpdatePolicyEngine();
    const manifest = UpdateManifest(
      latestVersionCode: 10,
      minSupportedVersionCode: 8,
      recommendedVersionCode: 10,
      graceHours: 72,
      apkUrl: 'https://example.com/app-sideload-release.apk',
      storeUrl: 'https://play.google.com/store/apps/details?id=x',
      releaseNotesUrl: 'https://example.com/releases',
    );

    test('returns upToDate when current version is latest', () {
      final decision = engine.evaluate(
        currentVersionCode: 10,
        manifest: manifest,
        now: DateTime(2026, 3, 10, 12),
        noUpdateMessage: 'up',
        availableMessage: 'available',
        requiredMessage: 'required',
        blockedMessage: 'blocked',
      );

      expect(decision.status, UpdateStatus.upToDate);
      expect(decision.action, UpdateAction.check);
    });

    test('returns available for optional updates', () {
      final decision = engine.evaluate(
        currentVersionCode: 9,
        manifest: manifest,
        now: DateTime(2026, 3, 10, 12),
        noUpdateMessage: 'up',
        availableMessage: 'available',
        requiredMessage: 'required',
        blockedMessage: 'blocked',
      );

      expect(decision.status, UpdateStatus.available);
      expect(decision.action, UpdateAction.downloadAndInstall);
    });

    test('returns requiredGrace before grace deadline', () {
      final now = DateTime(2026, 3, 10, 12);
      final decision = engine.evaluate(
        currentVersionCode: 7,
        manifest: manifest,
        now: now,
        graceDeadline: now.add(const Duration(hours: 10)),
        noUpdateMessage: 'up',
        availableMessage: 'available',
        requiredMessage: 'required',
        blockedMessage: 'blocked',
      );

      expect(decision.status, UpdateStatus.requiredGrace);
      expect(decision.action, UpdateAction.downloadAndInstall);
    });

    test('returns requiredBlocked after grace deadline', () {
      final now = DateTime(2026, 3, 10, 12);
      final decision = engine.evaluate(
        currentVersionCode: 7,
        manifest: manifest,
        now: now,
        graceDeadline: now.subtract(const Duration(hours: 1)),
        noUpdateMessage: 'up',
        availableMessage: 'available',
        requiredMessage: 'required',
        blockedMessage: 'blocked',
      );

      expect(decision.status, UpdateStatus.requiredBlocked);
      expect(decision.action, UpdateAction.downloadAndInstall);
    });
  });
}
