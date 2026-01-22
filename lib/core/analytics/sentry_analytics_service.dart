import 'dart:async';

import 'package:salat_tracker/core/analytics/analytics_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Analytics implementation using Sentry.
///
/// This leverages our existing Sentry integration for privacy-aware
/// event tracking without adding new 3rd party SDKs.
class SentryAnalyticsService implements AnalyticsService {
  const SentryAnalyticsService();

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    // Sentry "Transactions" or "Breadcrumbs" can be used here.
    // For analytics-like behavior, captureMessage or addBreadcrumb is common
    // depending on the tier. Here we use breadcrumbs for the timeline
    // and a custom event transaction for important KPIs if needed.

    // 1. Add to breadcrumbs (timeline)
    await Sentry.addBreadcrumb(
      Breadcrumb(
        category: 'analytics',
        message: name,
        data: parameters,
        level: SentryLevel.info,
      ),
    );
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await Sentry.configureScope((scope) async {
      await scope.setTag('screen', screenName);
    });
    await Sentry.addBreadcrumb(
      Breadcrumb(
        category: 'navigation',
        message: 'Navigated to $screenName',
        type: 'navigation',
      ),
    );
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    await Sentry.configureScope((scope) async {
      await scope.setTag(name, value);
    });
  }
}
