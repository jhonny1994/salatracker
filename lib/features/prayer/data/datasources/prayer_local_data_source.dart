import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';
import 'package:salat_tracker/shared/shared.dart';

class PrayerLocalDataSource {
  PrayerLocalDataSource(this._box);

  final Box<PrayerDay> _box;

  Future<void> upsertDay(PrayerDay day) async {
    await _box.put(day.date.storageKey, day);
  }

  PrayerDay? fetchDay(DateTime date) {
    return _box.get(date.storageKey);
  }

  Stream<List<PrayerDay>> watchDays() async* {
    yield _box.values.toList();
    yield* _box.watch().map((_) => _box.values.toList());
  }
}
