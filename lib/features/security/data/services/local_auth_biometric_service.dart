import 'package:local_auth/local_auth.dart';
import 'package:salat_tracker/features/security/data/services/biometric_auth_service.dart';

class LocalAuthBiometricService implements BiometricAuthService {
  LocalAuthBiometricService(this._localAuth);

  final LocalAuthentication _localAuth;

  @override
  Future<bool> canCheckBiometrics() {
    return _localAuth.canCheckBiometrics;
  }

  @override
  Future<bool> isDeviceSupported() {
    return _localAuth.isDeviceSupported();
  }

  @override
  Future<bool> authenticate({required String localizedReason}) {
    return _localAuth.authenticate(
      localizedReason: localizedReason,
      persistAcrossBackgrounding: true,
    );
  }
}
