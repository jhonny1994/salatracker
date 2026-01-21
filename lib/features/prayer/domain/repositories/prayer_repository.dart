import 'package:salat_tracker/features/prayer/prayer.dart';

abstract class PrayerRepository {
  Future<void> upsertDay(PrayerDay day);
  Future<PrayerDay?> fetchDay(DateTime date);
  Stream<List<PrayerDay>> watchDays();
}
