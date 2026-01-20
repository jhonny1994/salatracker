import 'package:salat_tracker/features/prayer/data/datasources/prayer_local_data_source.dart';
import 'package:salat_tracker/features/prayer/domain/models/prayer_day.dart';
import 'package:salat_tracker/features/prayer/domain/repositories/prayer_repository.dart';

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
