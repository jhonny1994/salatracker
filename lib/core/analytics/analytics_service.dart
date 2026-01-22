import 'dart:async';

/// Abstract interface for analytics services.
///
/// This allows us to switch between implementations (Firebase, PostHog,
/// Logging) without changing the core application logic.
abstract interface class AnalyticsService {
  /// Logs a custom event with optional parameters.
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  /// Sets a user property for audience segmentation.
  ///
  /// PII WARNING: Do not set PII (email, name, phone) here.
  Future<void> setUserProperty(String name, String value);

  /// Tracks the current screen view.
  Future<void> setCurrentScreen(String screenName);
}
