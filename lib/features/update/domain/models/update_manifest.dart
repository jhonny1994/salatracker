import 'dart:convert';

class UpdateManifest {
  const UpdateManifest({
    required this.latestVersionCode,
    required this.minSupportedVersionCode,
    required this.recommendedVersionCode,
    required this.graceHours,
    required this.apkUrl,
    required this.storeUrl,
    required this.releaseNotesUrl,
    this.sha256,
  });

  factory UpdateManifest.fromJson(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid update manifest format.');
    }

    return UpdateManifest(
      latestVersionCode: decoded['latest_version_code'] as int? ?? 0,
      minSupportedVersionCode:
          decoded['min_supported_version_code'] as int? ?? 0,
      recommendedVersionCode: decoded['recommended_version_code'] as int? ?? 0,
      graceHours: decoded['grace_hours'] as int? ?? 72,
      apkUrl: decoded['apk_url'] as String? ?? '',
      storeUrl: decoded['store_url'] as String? ?? '',
      releaseNotesUrl: decoded['release_notes_url'] as String? ?? '',
      sha256: decoded['sha256'] as String?,
    );
  }

  final int latestVersionCode;
  final int minSupportedVersionCode;
  final int recommendedVersionCode;
  final int graceHours;
  final String apkUrl;
  final String storeUrl;
  final String releaseNotesUrl;
  final String? sha256;
}
