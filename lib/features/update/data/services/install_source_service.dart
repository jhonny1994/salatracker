import 'package:package_info_plus/package_info_plus.dart';
import 'package:salat_tracker/features/update/update.dart';

class InstallSourceService {
  Future<UpdateChannel> detectChannel() async {
    final info = await PackageInfo.fromPlatform();
    final installer = info.installerStore?.toLowerCase();

    if (installer == null || installer.isEmpty) {
      return UpdateChannel.unknown;
    }

    if (installer.contains('com.android.vending') ||
        installer.contains('play')) {
      return UpdateChannel.play;
    }

    return UpdateChannel.github;
  }

  Future<int> currentVersionCode() async {
    final info = await PackageInfo.fromPlatform();
    final value = int.tryParse(info.buildNumber);
    return value ?? 0;
  }
}
