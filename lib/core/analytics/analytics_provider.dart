import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salat_tracker/core/analytics/analytics_service.dart';
import 'package:salat_tracker/core/analytics/sentry_analytics_service.dart';

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
