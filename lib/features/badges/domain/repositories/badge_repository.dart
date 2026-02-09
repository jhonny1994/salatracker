import 'package:salat_tracker/features/badges/domain/models/badge_award.dart';

abstract class BadgeRepository {
  Future<List<BadgeAward>> fetchAwards();
  Future<void> saveAwards(List<BadgeAward> awards);
  Stream<List<BadgeAward>> watchAwards();
}
