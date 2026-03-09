import 'package:salat_tracker/features/badges/badges.dart';

class BadgeRepositoryImpl implements BadgeRepository {
  BadgeRepositoryImpl(this._localDataSource);

  final BadgeLocalDataSource _localDataSource;

  @override
  Future<List<BadgeAward>> fetchAwards() {
    return _localDataSource.fetchAwards();
  }

  @override
  Future<void> saveAwards(List<BadgeAward> awards) {
    return _localDataSource.saveAwards(awards);
  }

  @override
  Stream<List<BadgeAward>> watchAwards() {
    return _localDataSource.watchAwards();
  }
}
