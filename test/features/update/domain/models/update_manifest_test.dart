import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/update/update.dart';

void main() {
  group('UpdateManifest', () {
    test('parses valid json payload', () {
      const payload = '''
{
  "latest_version_code": 10,
  "min_supported_version_code": 8,
  "recommended_version_code": 9,
  "grace_hours": 72,
  "apk_url": "https://example.com/app-release.apk",
  "store_url": "https://play.google.com/store/apps/details?id=x",
  "release_notes_url": "https://example.com/releases",
  "sha256": "abc"
}
''';

      final manifest = UpdateManifest.fromJson(payload);

      expect(manifest.latestVersionCode, 10);
      expect(manifest.minSupportedVersionCode, 8);
      expect(manifest.recommendedVersionCode, 9);
      expect(manifest.graceHours, 72);
      expect(manifest.apkUrl, 'https://example.com/app-release.apk');
      expect(manifest.sha256, 'abc');
    });

    test('throws for non-map payload', () {
      expect(
        () => UpdateManifest.fromJson('[1,2,3]'),
        throwsA(isA<FormatException>()),
      );
    });

    test('parses default values when keys are missing', () {
      final manifest = UpdateManifest.fromJson('{}');

      expect(manifest.latestVersionCode, 0);
      expect(manifest.minSupportedVersionCode, 0);
      expect(manifest.recommendedVersionCode, 0);
      expect(manifest.graceHours, 72);
      expect(manifest.apkUrl, isEmpty);
      expect(manifest.storeUrl, isEmpty);
      expect(manifest.releaseNotesUrl, isEmpty);
      expect(manifest.sha256, isNull);
    });

    test('keeps sha256 when provided', () {
      const payload = '''
{
  "latest_version_code": 10,
  "min_supported_version_code": 8,
  "recommended_version_code": 9,
  "grace_hours": 72,
  "apk_url": "https://example.com/app-release.apk",
  "store_url": "https://play.google.com/store/apps/details?id=x",
  "release_notes_url": "https://example.com/releases",
  "sha256": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}
''';

      final manifest = UpdateManifest.fromJson(payload);
      expect(
        manifest.sha256,
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      );
    });
  });
}
