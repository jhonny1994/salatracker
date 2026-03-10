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

  static String m0(date) => "Earned on ${date}";

  static String m1(completed, total) => "${completed}/${total}";

  static String m2(time) => "Logged at ${time}";

  static String m3(time) => "Have you prayed today? (${time})";

  static String m4(prayer) => "It is time for ${prayer} prayer.";

  static String m5(prayer) => "Time for ${prayer}";

  static String m6(minutes) => "${minutes} min";

  static String m7(current, total) => "Step ${current} of ${total}";

  static String m8(seconds) => "Try again in ${seconds}s";

  static String m9(value) => "Current Time Zone: ${value}";

  static String m10(number) => "Reminder ${number}";

  static String m11(prayer) => "Reminder Offset - ${prayer}";

  static String m12(completed, total) => "${completed}/${total}";

  static String m13(count) => "${count} of 5 prayers logged";

  static String m14(count) => "${count} points";

  static String m15(count) => "${count} day streak";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "actionContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "actionRemove": MessageLookupByLibrary.simpleMessage("Remove"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "badgeFirstPrayerDescription": MessageLookupByLibrary.simpleMessage(
      "Logged your first prayer entry.",
    ),
    "badgeFirstPrayerName": MessageLookupByLibrary.simpleMessage(
      "First Prayer Logged",
    ),
    "badgeMonthCompleteDescription": MessageLookupByLibrary.simpleMessage(
      "Reached 90% completion in a month.",
    ),
    "badgeMonthCompleteName": MessageLookupByLibrary.simpleMessage(
      "Month Complete",
    ),
    "badgeSeasonChampionDescription": MessageLookupByLibrary.simpleMessage(
      "Reached 80% completion in 3 months.",
    ),
    "badgeSeasonChampionName": MessageLookupByLibrary.simpleMessage(
      "Season Champion",
    ),
    "badgeWeekConsistencyDescription": MessageLookupByLibrary.simpleMessage(
      "Completed 7 full prayer days.",
    ),
    "badgeWeekConsistencyName": MessageLookupByLibrary.simpleMessage(
      "Week of Consistency",
    ),
    "badgesEarnedOn": m0,
    "badgesEmpty": MessageLookupByLibrary.simpleMessage(
      "No badges yet. Keep logging your prayers.",
    ),
    "badgesTitle": MessageLookupByLibrary.simpleMessage("Badges"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "calendarCompletionRatio": m1,
    "calendarLoggedAt": m2,
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
    "dailyReminderBody": MessageLookupByLibrary.simpleMessage(
      "Have you prayed today?",
    ),
    "dailyReminderTileSubtitle": m3,
    "dailyReminderTitle": MessageLookupByLibrary.simpleMessage(
      "Prayer Check-in",
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
    "generalLoading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "generalNo": MessageLookupByLibrary.simpleMessage("Disabled"),
    "generalYes": MessageLookupByLibrary.simpleMessage("Enabled"),
    "historyEditWarningBody": MessageLookupByLibrary.simpleMessage(
      "Changing past records may affect your streak and points.",
    ),
    "historyEditWarningTitle": MessageLookupByLibrary.simpleMessage(
      "Edit History?",
    ),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "navToday": MessageLookupByLibrary.simpleMessage("Today"),
    "notificationBody": m4,
    "notificationChannelDescription": MessageLookupByLibrary.simpleMessage(
      "Notifications for prayer times",
    ),
    "notificationChannelName": MessageLookupByLibrary.simpleMessage(
      "Prayer Notifications",
    ),
    "notificationTitle": m5,
    "offsetMinutes": m6,
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
    "onboardingEnableLocation": MessageLookupByLibrary.simpleMessage(
      "Enable Location",
    ),
    "onboardingEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Enable Notifications",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "onboardingLateReminderBody": MessageLookupByLibrary.simpleMessage(
      "Choose a time for your daily check-in.",
    ),
    "onboardingLateReminderTitle": MessageLookupByLibrary.simpleMessage(
      "Late-day reminder",
    ),
    "onboardingLocationBody": MessageLookupByLibrary.simpleMessage(
      "Allow location access to accurately determine your city and timezone for prayer schedules.",
    ),
    "onboardingLocationPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "Location stays off for now. You can continue or choose Maybe Later.",
    ),
    "onboardingLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Detect Your Location",
    ),
    "onboardingMaybeLater": MessageLookupByLibrary.simpleMessage("Maybe Later"),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("Next"),
    "onboardingNotificationsBody": MessageLookupByLibrary.simpleMessage(
      "Would you like friendly reminders?",
    ),
    "onboardingNotificationsPermissionDenied":
        MessageLookupByLibrary.simpleMessage(
          "Notifications stay off for now. You can enable them later in Settings.",
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
    "onboardingProgress": m7,
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
    "routerError": MessageLookupByLibrary.simpleMessage("Route error"),
    "securityBiometricReason": MessageLookupByLibrary.simpleMessage(
      "Authenticate to unlock Salat Tracker",
    ),
    "securityConfirmPinLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm PIN",
    ),
    "securityCurrentPinError": MessageLookupByLibrary.simpleMessage(
      "Current PIN is incorrect",
    ),
    "securityCurrentPinLabel": MessageLookupByLibrary.simpleMessage(
      "Current PIN",
    ),
    "securityCurrentPinTitle": MessageLookupByLibrary.simpleMessage(
      "Enter current PIN",
    ),
    "securityLockoutSeconds": m8,
    "securityPinDigitsError": MessageLookupByLibrary.simpleMessage(
      "PIN must be exactly 6 digits",
    ),
    "securityPinLabel": MessageLookupByLibrary.simpleMessage("PIN"),
    "securityPinMismatchError": MessageLookupByLibrary.simpleMessage(
      "PINs do not match",
    ),
    "securitySetPinTitle": MessageLookupByLibrary.simpleMessage(
      "Set a 6-digit PIN",
    ),
    "securityUnlockTitle": MessageLookupByLibrary.simpleMessage(
      "Unlock Salat Tracker",
    ),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("About"),
    "settingsAddDailyReminder": MessageLookupByLibrary.simpleMessage(
      "Add Reminder",
    ),
    "settingsAppLock": MessageLookupByLibrary.simpleMessage("App Lock"),
    "settingsAppLockSubtitle": MessageLookupByLibrary.simpleMessage(
      "Require unlock after screen off",
    ),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage("App Version"),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "settingsBadges": MessageLookupByLibrary.simpleMessage("Badges"),
    "settingsBadgesSubtitle": MessageLookupByLibrary.simpleMessage(
      "View reflective milestones",
    ),
    "settingsBiometricUnlock": MessageLookupByLibrary.simpleMessage(
      "Biometric Unlock",
    ),
    "settingsBiometricUnlockSubtitle": MessageLookupByLibrary.simpleMessage(
      "Use biometrics before PIN on lock screen",
    ),
    "settingsBiometricUnlockUnavailable": MessageLookupByLibrary.simpleMessage(
      "Biometrics unavailable on this device",
    ),
    "settingsContactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "settingsContactUsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Reach out for support or feedback",
    ),
    "settingsCurrentTimezone": MessageLookupByLibrary.simpleMessage(
      "Current Time Zone",
    ),
    "settingsCurrentTimezoneUnavailable": MessageLookupByLibrary.simpleMessage(
      "Time zone unavailable",
    ),
    "settingsCurrentTimezoneValue": m9,
    "settingsDailyReminderLabel": m10,
    "settingsDailyReminders": MessageLookupByLibrary.simpleMessage(
      "Daily Reminders",
    ),
    "settingsDailyRemindersEmpty": MessageLookupByLibrary.simpleMessage(
      "No daily reminders yet.",
    ),
    "settingsDailyRemindersSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add late-day check-ins in your own rhythm",
    ),
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
    "settingsReminderDuplicateTime": MessageLookupByLibrary.simpleMessage(
      "You already have a reminder at this time.",
    ),
    "settingsReminderOffset": MessageLookupByLibrary.simpleMessage(
      "Reminder Offset",
    ),
    "settingsReminderOffsetFor": m11,
    "settingsReminderOffsetSubtitle": MessageLookupByLibrary.simpleMessage(
      "Adjust when you get notified",
    ),
    "settingsResetPin": MessageLookupByLibrary.simpleMessage("Reset PIN"),
    "settingsResetPinSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set a new app lock PIN",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage("Show Points"),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Display points in UI",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("Theme"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "settingsUpdates": MessageLookupByLibrary.simpleMessage("App Updates"),
    "settingsVersionLoading": MessageLookupByLibrary.simpleMessage(
      "Loading...",
    ),
    "settingsWeekStart": MessageLookupByLibrary.simpleMessage("Week Start"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("Tap to log"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "All prayers completed!",
    ),
    "todayCompletionRatio": m12,
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Keep going, you\'re doing great!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage("No prayers logged yet"),
    "todayPartial": m13,
    "todayPoints": m14,
    "todayProgress": MessageLookupByLibrary.simpleMessage("Today\'s Progress"),
    "todayStreak": m15,
    "updateActionNow": MessageLookupByLibrary.simpleMessage("Update now"),
    "updateAvailable": MessageLookupByLibrary.simpleMessage(
      "A new version is available",
    ),
    "updateCheckFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to check updates right now",
    ),
    "updateDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to download update",
    ),
    "updateDownloading": MessageLookupByLibrary.simpleMessage(
      "Downloading latest update...",
    ),
    "updateInstallFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to launch installer",
    ),
    "updateReadyToInstall": MessageLookupByLibrary.simpleMessage(
      "Download complete. Opening installer...",
    ),
    "updateRequiredBlocked": MessageLookupByLibrary.simpleMessage(
      "Update required to continue",
    ),
    "updateRequiredGrace": MessageLookupByLibrary.simpleMessage(
      "A critical update is required soon",
    ),
    "updateTapToCheck": MessageLookupByLibrary.simpleMessage(
      "Tap to check for updates",
    ),
    "updateUpToDate": MessageLookupByLibrary.simpleMessage(
      "You are on the latest version",
    ),
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Monday"),
    "weekStartSaturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Sunday"),
  };
}
