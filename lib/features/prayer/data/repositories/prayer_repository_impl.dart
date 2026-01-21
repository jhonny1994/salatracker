import 'package:salat_tracker/features/prayer/prayer.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  PrayerRepositoryImpl(this._localDataSource);

  final PrayerLocalDataSource _localDataSource;

  @override
  Future<void> upsertDay(PrayerDay day) {
    return _localDataSource.upsertDay(day);
  }

  @override
  Future<PrayerDay?> fetchDay(DateTime date) async {
    return _localDataSource.fetchDay(date);
  }

  @override
  Stream<List<PrayerDay>> watchDays() {
    return _localDataSource.watchDays();
  }
}
