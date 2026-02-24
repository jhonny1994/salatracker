import 'package:local_auth/local_auth.dart';

abstract class BiometricAuthService {
  Future<bool> canCheckBiometrics();
  Future<bool> isDeviceSupported();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<bool> authenticate({required String localizedReason});
}
