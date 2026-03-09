import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/core.dart';

part 'analytics_provider.g.dart';

/// Provides the platform-specific analytics implementation.
///
/// In debug mode, this returns [SentryAnalyticsService].
/// In release mode, this could return Firebase/PostHog/etc.
@Riverpod(keepAlive: true)
AnalyticsService analytics(Ref ref) {
  // Enterprise Grade: Leverage existing infrastructure.
  return const SentryAnalyticsService();
}
