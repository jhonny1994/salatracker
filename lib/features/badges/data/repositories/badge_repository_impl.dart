import 'package:salat_tracker/features/badges/data/datasources/badge_local_data_source.dart';
import 'package:salat_tracker/features/badges/domain/models/badge_award.dart';
import 'package:salat_tracker/features/badges/domain/repositories/badge_repository.dart';

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
