import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_award.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_type.dart';

class BadgeLocalDataSource {
  BadgeLocalDataSource(this._box);

  final Box<BadgeAward> _box;

  Future<List<BadgeAward>> fetchAwards() async {
    final awards = _box.values.toList()
      ..sort((a, b) => a.earnedAt.compareTo(b.earnedAt));
    return awards;
  }

  Future<void> saveAwards(List<BadgeAward> awards) async {
    final map = <String, BadgeAward>{
      for (final award in awards) award.type.name: award,
    };

    await _box.clear();
    await _box.putAll(map);
  }

  Stream<List<BadgeAward>> watchAwards() async* {
    yield await fetchAwards();
    yield* _box.watch().asyncMap((_) => fetchAwards());
  }

  Future<void> saveAward(BadgeAward award) async {
    await _box.put(award.type.name, award);
  }

  Future<BadgeAward?> fetchAward(BadgeType type) async {
    return _box.get(type.name);
  }
}
