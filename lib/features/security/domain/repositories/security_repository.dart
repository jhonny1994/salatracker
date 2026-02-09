/// Repository interface for security and authentication operations.
///
/// Handles PIN management, biometric authentication, and app lock state
/// persistence.
abstract class SecurityRepository {
  /// Sets a new PIN for the application.
  Future<void> setPin(String pin);

  /// Verifies if the provided PIN matches the stored one.
  Future<bool> verifyPin(String pin);

  /// Checks if a PIN is currently set.
  Future<bool> hasPin();

  /// Removes the stored PIN.
  Future<void> removePin();

  /// Checks if App Lock is enabled in settings.
  Future<bool> isAppLockEnabled();

  /// Enables or disables App Lock.
  Future<void> setAppLockEnabled({required bool enabled});

  /// Authenticates the user using biometrics.
  ///
  /// Returns true if authentication is successful, false otherwise.
  Future<bool> authenticateWithBiometrics({required String reason});

  /// Checks if biometric authentication is available on the device.
  Future<bool> isBiometricsAvailable();
}
