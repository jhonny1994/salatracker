// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(time) => "Logged at ${time}";

  static String m1(prayer) => "It is time for ${prayer} prayer.";

  static String m2(prayer) => "Time for ${prayer}";

  static String m3(minutes) => "${minutes} min";

  static String m4(count) => "${count} of 5 prayers logged";

  static String m5(count) => "${count} points";

  static String m6(count) => "${count} day streak";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "actionContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "calendarLoggedAt": m0,
    "calendarNoData": MessageLookupByLibrary.simpleMessage(
      "No prayers logged for this day",
    ),
    "calendarNoPrayers": MessageLookupByLibrary.simpleMessage(
      "No prayers logged",
    ),
    "calendarPoints": MessageLookupByLibrary.simpleMessage("Points"),
    "calendarPrayers": MessageLookupByLibrary.simpleMessage("Prayers"),
    "calendarStreamRetry": MessageLookupByLibrary.simpleMessage(
      "Stream will retry automatically",
    ),
    "endOfDayBody": MessageLookupByLibrary.simpleMessage(
      "Did you complete all your prayers today?",
    ),
    "endOfDayTitle": MessageLookupByLibrary.simpleMessage("Daily Reflection"),
    "errorLoadingCalendar": MessageLookupByLibrary.simpleMessage(
      "Failed to load calendar",
    ),
    "errorLoadingData": MessageLookupByLibrary.simpleMessage(
      "Error loading data",
    ),
    "errorLoadingSettings": MessageLookupByLibrary.simpleMessage(
      "Failed to load settings",
    ),
    "errorRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "historyEditWarningBody": MessageLookupByLibrary.simpleMessage(
      "Changing past records may affect your streak and points.",
    ),
    "historyEditWarningTitle": MessageLookupByLibrary.simpleMessage(
      "Edit History?",
    ),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "navToday": MessageLookupByLibrary.simpleMessage("Today"),
    "notificationBody": m1,
    "notificationTitle": m2,
    "offsetMinutes": m3,
    "onboardingAppLockBody": MessageLookupByLibrary.simpleMessage(
      "Secure your prayer log with biometrics or PIN.",
    ),
    "onboardingAppLockTitle": MessageLookupByLibrary.simpleMessage(
      "Protect Your Privacy",
    ),
    "onboardingBack": MessageLookupByLibrary.simpleMessage("Back"),
    "onboardingConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Review your settings and start tracking.",
    ),
    "onboardingConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "You\'re All Set",
    ),
    "onboardingEnableAppLock": MessageLookupByLibrary.simpleMessage(
      "Enable App Lock",
    ),
    "onboardingEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Enable Notifications",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingMaybeLater": MessageLookupByLibrary.simpleMessage("Maybe Later"),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("Next"),
    "onboardingNotificationsBody": MessageLookupByLibrary.simpleMessage(
      "Would you like friendly reminders?",
    ),
    "onboardingNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Stay on Track",
    ),
    "onboardingPrayerTimesBody": MessageLookupByLibrary.simpleMessage(
      "Configure when each prayer time begins.",
    ),
    "onboardingPrayerTimesTitle": MessageLookupByLibrary.simpleMessage(
      "Set Your Prayer Times",
    ),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "Track your daily prayers with gentle reminders.",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Salat Tracker",
    ),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("Asr"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("Isha"),
    "prayerJumuah": MessageLookupByLibrary.simpleMessage("Jumu\'ah"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("About"),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage("App Version"),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("Haptic Feedback"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vibrate on interactions",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsLanguageArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "settingsLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "settingsNotificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enable prayer time alerts",
    ),
    "settingsPrayerSchedule": MessageLookupByLibrary.simpleMessage(
      "Prayer Schedule",
    ),
    "settingsPrayerScheduleSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set custom prayer times",
    ),
    "settingsPreferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Privacy Policy",
    ),
    "settingsReminderOffset": MessageLookupByLibrary.simpleMessage(
      "Reminder Offset",
    ),
    "settingsReminderOffsetSubtitle": MessageLookupByLibrary.simpleMessage(
      "Adjust when you get notified",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage("Show Points"),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Display points in UI",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("Theme"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "settingsWeekStart": MessageLookupByLibrary.simpleMessage("Week Start"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("Tap to log"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "All prayers completed!",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Keep going, you\'re doing great!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage("No prayers logged yet"),
    "todayPartial": m4,
    "todayPoints": m5,
    "todayProgress": MessageLookupByLibrary.simpleMessage("Today\'s Progress"),
    "todayStreak": m6,
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Sunday"),
  };
}
