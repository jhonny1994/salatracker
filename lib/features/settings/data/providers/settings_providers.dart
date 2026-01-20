import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/storage/hive_service.dart';
import 'package:salat_tracker/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:salat_tracker/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:salat_tracker/features/settings/domain/models/settings.dart';
import 'package:salat_tracker/features/settings/domain/repositories/settings_repository.dart';

part 'settings_providers.g.dart';

@riverpod
SettingsLocalDataSource settingsLocalDataSource(Ref ref) {
  final box = Hive.box<Settings>(HiveService.settingsBoxName);
  return SettingsLocalDataSource(box);
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepositoryImpl(ref.read(settingsLocalDataSourceProvider));
}
