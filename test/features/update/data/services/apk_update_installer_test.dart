import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/update/data/services/apk_update_installer.dart';

void main() {
  test('sha256convert computes expected digest', () {
    final installer = ApkUpdateInstaller();
    final digest = installer.sha256convert('abc'.codeUnits);
    expect(
      digest,
      'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad',
    );
  });
}
