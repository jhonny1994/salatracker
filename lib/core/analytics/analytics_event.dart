/// Type-safe definitions for analytics events to prevent string typos.
class AnalyticsEvent {
  // Prayer Events
  static const String prayerLogged = 'prayer_logged';

  // Calendar Events
  static const String historyViewed = 'history_viewed';

  // Settings Events
  static const String themeChanged = 'theme_changed';
  static const String languageChanged = 'language_changed';
  static const String hapticsToggled = 'haptics_toggled';
  static const String pointsToggled = 'points_toggled';
}

/// Type-safe definitions for analytics parameters.
class AnalyticsParam {
  static const String prayerType = 'prayer_type';
  static const String isOnTime = 'is_on_time';
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String enabled = 'enabled';
  static const String month = 'month';
  static const String year = 'year';
}
