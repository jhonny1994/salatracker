import 'package:in_app_update/in_app_update.dart';

class PlayUpdateService {
  Future<bool> checkForUpdate() async {
    final info = await InAppUpdate.checkForUpdate();
    return info.updateAvailability == UpdateAvailability.updateAvailable;
  }

  Future<void> performImmediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }
}
