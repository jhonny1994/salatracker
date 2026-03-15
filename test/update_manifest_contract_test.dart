import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('update-manifest includes required keys and non-empty sha256', () async {
    final file = File('update-manifest.json');
    expect(file.existsSync(), isTrue);

    final decoded = jsonDecode(await file.readAsString());
    expect(decoded, isA<Map<String, dynamic>>());

    final json = decoded as Map<String, dynamic>;
    expect(json['latest_version_code'], isA<int>());
    expect(json['min_supported_version_code'], isA<int>());
    expect(json['recommended_version_code'], isA<int>());
    expect(json['grace_hours'], isA<int>());
    expect((json['apk_url'] as String).startsWith('https://'), isTrue);
    expect((json['store_url'] as String).startsWith('https://'), isTrue);
    expect(
      (json['release_notes_url'] as String).startsWith('https://'),
      isTrue,
    );

    final sha = (json['sha256'] as String?) ?? '';
    expect(sha.trim().isNotEmpty, isTrue);
    expect(sha, isNot('replace_with_real_sha256_from_release_apk'));
    expect(RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(sha), isTrue);

    final latest = json['latest_version_code'] as int;
    final minSupported = json['min_supported_version_code'] as int;
    final recommended = json['recommended_version_code'] as int;
    final graceHours = json['grace_hours'] as int;

    expect(latest > 0, isTrue);
    expect(minSupported >= 0, isTrue);
    expect(recommended >= minSupported, isTrue);
    expect(latest >= recommended, isTrue);
    expect(graceHours >= 1 && graceHours <= 168, isTrue);
    expect(
      (json['apk_url'] as String).endsWith('/app-sideload-release.apk'),
      isTrue,
    );
  });
}
