import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:salat_tracker/core/storage/adapters/time_of_day_adapter.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_award.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_type.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/features/settings/settings.dart';

/// Local storage service using Hive.
///
/// Manages box initialization, schema migration, and adapter registration.
/// This service acts as the data abstraction layer for persistent storage.
class HiveService {
  static const settingsBoxName = 'settings';
  static const prayerDaysBoxName = 'prayer_days';
  static const badgesBoxName = 'badge_awards';
  static const metaBoxName = 'meta';
  static const locationBoxName = 'location_context';
  static const schemaVersionKey = 'schema_version';
  static const schemaVersion = 1;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _registerAdapters();
    final metaBox = await Hive.openBox<int>(metaBoxName);
    await _ensureSchemaVersion(metaBox);
    await Hive.openBox<Settings>(settingsBoxName);
    await Hive.openBox<PrayerDay>(prayerDaysBoxName);
    await Hive.openBox<BadgeAward>(badgesBoxName);
    await Hive.openBox<String>(locationBoxName);
  }

  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(PrayerTypeAdapter().typeId)) {
      Hive.registerAdapter(PrayerTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(TimeOfDayAdapter().typeId)) {
      Hive.registerAdapter(TimeOfDayAdapter());
    }
    if (!Hive.isAdapterRegistered(PrayerEntryAdapter().typeId)) {
      Hive.registerAdapter(PrayerEntryAdapter());
    }
    if (!Hive.isAdapterRegistered(PrayerDayAdapter().typeId)) {
      Hive.registerAdapter(PrayerDayAdapter());
    }
    if (!Hive.isAdapterRegistered(AppThemeModeAdapter().typeId)) {
      Hive.registerAdapter(AppThemeModeAdapter());
    }
    if (!Hive.isAdapterRegistered(SettingsAdapter().typeId)) {
      Hive.registerAdapter(SettingsAdapter());
    }
    if (!Hive.isAdapterRegistered(BadgeTypeAdapter().typeId)) {
      Hive.registerAdapter(BadgeTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(BadgeAwardAdapter().typeId)) {
      Hive.registerAdapter(BadgeAwardAdapter());
    }
  }

  static Future<void> _ensureSchemaVersion(Box<int> metaBox) async {
    final storedVersion = metaBox.get(schemaVersionKey);
    if (storedVersion == null) {
      await metaBox.put(schemaVersionKey, schemaVersion);
      return;
    }
    if (storedVersion != schemaVersion) {
      await _migrateSchema(storedVersion, schemaVersion);
      await metaBox.put(schemaVersionKey, schemaVersion);
    }
  }

  static Future<void> _migrateSchema(int fromVersion, int toVersion) async {
    for (var version = fromVersion; version < toVersion; version++) {
      switch (version) {
        case 0:
          break;
      }
    }
  }
}
