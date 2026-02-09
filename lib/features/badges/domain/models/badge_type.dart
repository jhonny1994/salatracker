import 'package:hive_ce/hive.dart';

part 'badge_type.g.dart';

@HiveType(typeId: 20)
enum BadgeType {
  @HiveField(0)
  firstPrayerLogged,
  @HiveField(1)
  weekConsistency,
  @HiveField(2)
  monthComplete,
  @HiveField(3)
  seasonChampion,
}
