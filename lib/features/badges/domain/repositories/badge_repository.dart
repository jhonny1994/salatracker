import 'package:salat_tracker/features/badges/badges.dart';

abstract class BadgeRepository {
  Future<List<BadgeAward>> fetchAwards();
  Future<void> saveAwards(List<BadgeAward> awards);
  Stream<List<BadgeAward>> watchAwards();
}
