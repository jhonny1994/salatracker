import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salat_tracker/shared/shared.dart';

enum ApkUpdateInstallerError {
  downloadFailed,
  checksumMissing,
  checksumMismatch,
  installerLaunchFailed,
}

class ApkUpdateInstallerException implements Exception {
  const ApkUpdateInstallerException(this.error, {this.details});

  final ApkUpdateInstallerError error;
  final String? details;
}

class ApkUpdateInstaller {
  ApkUpdateInstaller({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<String> downloadLatestApk(
    String url, {
    required String? sha256,
  }) async {
    final uri = Uri.parse(url);
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw ApkUpdateInstallerException(
        ApkUpdateInstallerError.downloadFailed,
        details: '${response.statusCode}',
      );
    }

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${AppConstants.releaseApkFileName}');
    await file.writeAsBytes(response.bodyBytes, flush: true);

    if (sha256 == null || sha256.trim().isEmpty) {
      throw const ApkUpdateInstallerException(
        ApkUpdateInstallerError.checksumMissing,
      );
    }

    final digest = sha256convert(response.bodyBytes);
    if (digest.toLowerCase() != sha256.toLowerCase()) {
      throw const ApkUpdateInstallerException(
        ApkUpdateInstallerError.checksumMismatch,
      );
    }

    return file.path;
  }

  String sha256convert(List<int> bytes) {
    return sha256.convert(bytes).toString();
  }

  Future<void> installFromPath(String path) async {
    final result = await OpenFilex.open(path);
    if (result.type != ResultType.done) {
      throw ApkUpdateInstallerException(
        ApkUpdateInstallerError.installerLaunchFailed,
        details: result.message,
      );
    }
  }
}
