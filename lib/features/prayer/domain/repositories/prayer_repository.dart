import 'package:salat_tracker/features/prayer/prayer.dart';

/// Repository interface for prayer data persistence.
abstract class PrayerRepository {
  Future<void> upsertDay(PrayerDay day);
  Future<PrayerDay?> fetchDay(DateTime date);
  Stream<List<PrayerDay>> watchDays();
}
