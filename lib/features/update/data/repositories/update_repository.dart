import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:salat_tracker/features/update/update.dart';
import 'package:salat_tracker/shared/shared.dart';

enum UpdateRepositoryError {
  latestReleaseUnavailable,
  invalidLatestReleasePayload,
  invalidManifestPayload,
}

class UpdateRepositoryException implements Exception {
  const UpdateRepositoryException(this.error, {this.details});

  final UpdateRepositoryError error;
  final String? details;
}

class UpdateRepository {
  UpdateRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<UpdateManifest> fetchManifest() async {
    try {
      final uri = Uri.parse(AppConstants.updateManifestUrl);
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final manifest = UpdateManifest.fromJson(
          utf8.decode(response.bodyBytes),
        );
        _validateManifest(manifest);
        return manifest;
      }
    } on Object {
      // Fall back to latest release payload.
    }

    return _fetchFromLatestRelease();
  }

  Future<UpdateManifest> _fetchFromLatestRelease() async {
    final uri = Uri.https(
      'api.github.com',
      '/repos/${AppConstants.githubRepoSlug}/releases/latest',
    );
    final response = await _client
        .get(
          uri,
          headers: const {'Accept': 'application/vnd.github+json'},
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw UpdateRepositoryException(
        UpdateRepositoryError.latestReleaseUnavailable,
        details: '${response.statusCode}',
      );
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw const UpdateRepositoryException(
        UpdateRepositoryError.invalidLatestReleasePayload,
      );
    }

    final tag = decoded['tag_name'] as String? ?? '';
    final htmlUrl = decoded['html_url'] as String? ?? '';
    final latestCode = _extractBuildNumber(tag);

    var apkUrl = '';
    final assets = decoded['assets'];
    if (assets is List) {
      for (final asset in assets) {
        if (asset is! Map<String, dynamic>) {
          continue;
        }
        final name = (asset['name'] as String? ?? '').toLowerCase();
        if (name == AppConstants.releaseApkFileName) {
          apkUrl = asset['browser_download_url'] as String? ?? '';
          break;
        }
      }
    }

    final manifest = UpdateManifest(
      latestVersionCode: latestCode,
      minSupportedVersionCode: 0,
      recommendedVersionCode: latestCode,
      graceHours: 72,
      apkUrl: apkUrl.isEmpty ? htmlUrl : apkUrl,
      storeUrl: AppConstants.playStoreUrl,
      releaseNotesUrl: htmlUrl,
    );
    _validateManifest(manifest, allowMissingChecksum: true);
    return manifest;
  }

  void _validateManifest(
    UpdateManifest manifest, {
    bool allowMissingChecksum = false,
  }) {
    final validVersions =
        manifest.latestVersionCode > 0 &&
        manifest.recommendedVersionCode >= manifest.minSupportedVersionCode &&
        manifest.latestVersionCode >= manifest.recommendedVersionCode;
    final validGrace = manifest.graceHours >= 1 && manifest.graceHours <= 168;
    final apkHttps = _isHttps(manifest.apkUrl);
    final storeHttps = _isHttps(manifest.storeUrl);
    final releaseNotesHttps = _isHttps(manifest.releaseNotesUrl);

    final sha = manifest.sha256?.trim() ?? '';
    final shaValid =
        sha.isNotEmpty && RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(sha);
    final checksumOk = allowMissingChecksum || shaValid;

    if (!validVersions ||
        !validGrace ||
        !apkHttps ||
        !storeHttps ||
        !releaseNotesHttps ||
        !checksumOk) {
      throw const UpdateRepositoryException(
        UpdateRepositoryError.invalidManifestPayload,
      );
    }
  }

  bool _isHttps(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.scheme == 'https';
  }

  int _extractBuildNumber(String tag) {
    final plusMatch = RegExp(r'\+(\d+)$').firstMatch(tag);
    if (plusMatch != null) {
      return int.tryParse(plusMatch.group(1) ?? '') ?? 0;
    }

    final tailDigits = RegExp(r'(\d+)$').firstMatch(tag);
    return int.tryParse(tailDigits?.group(1) ?? '') ?? 0;
  }
}
