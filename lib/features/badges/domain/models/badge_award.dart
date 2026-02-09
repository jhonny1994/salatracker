import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_type.dart';

part 'badge_award.freezed.dart';
part 'badge_award.g.dart';

@freezed
@HiveType(typeId: 21)
abstract class BadgeAward with _$BadgeAward {
  const factory BadgeAward({
    @HiveField(0) required BadgeType type,
    @HiveField(1) required DateTime earnedAt,
  }) = _BadgeAward;
}
