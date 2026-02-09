// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(date) => "تم الحصول عليها في ${date}";

  static String m1(time) => "سُجِّل في ${time}";

  static String m2(prayer) => "حان الآن وقت صلاة ${prayer}";

  static String m3(prayer) => "وقت ${prayer}";

  static String m4(minutes) => "${minutes} دقيقة";

  static String m5(count) => "${count} من 5 صلوات مسجلة";

  static String m6(count) => "${count} نقطة";

  static String m7(count) => "سلسلة ${count} يوم";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionCancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "actionContinue": MessageLookupByLibrary.simpleMessage("استمرار"),
    "appTitle": MessageLookupByLibrary.simpleMessage("سجل الصلاة"),
    "badgeFirstPrayerDescription": MessageLookupByLibrary.simpleMessage(
      "قمت بتسجيل أول صلاة لك.",
    ),
    "badgeFirstPrayerName": MessageLookupByLibrary.simpleMessage(
      "أول صلاة مسجلة",
    ),
    "badgeMonthCompleteDescription": MessageLookupByLibrary.simpleMessage(
      "حققت 90% إكمال خلال شهر.",
    ),
    "badgeMonthCompleteName": MessageLookupByLibrary.simpleMessage(
      "إنجاز الشهر",
    ),
    "badgeSeasonChampionDescription": MessageLookupByLibrary.simpleMessage(
      "حققت 80% إكمال خلال 3 أشهر.",
    ),
    "badgeSeasonChampionName": MessageLookupByLibrary.simpleMessage(
      "بطل الموسم",
    ),
    "badgeWeekConsistencyDescription": MessageLookupByLibrary.simpleMessage(
      "أكملت 7 أيام كاملة من الصلوات.",
    ),
    "badgeWeekConsistencyName": MessageLookupByLibrary.simpleMessage(
      "أسبوع من الالتزام",
    ),
    "badgesEarnedOn": m0,
    "badgesEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد شارات بعد. استمر في تسجيل صلواتك.",
    ),
    "badgesTitle": MessageLookupByLibrary.simpleMessage("الشارات"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "calendarLoggedAt": m1,
    "calendarNoData": MessageLookupByLibrary.simpleMessage(
      "لا توجد صلوات مسجلة لهذا اليوم",
    ),
    "calendarNoPrayers": MessageLookupByLibrary.simpleMessage(
      "لا توجد صلوات مسجلة",
    ),
    "calendarPoints": MessageLookupByLibrary.simpleMessage("النقاط"),
    "calendarPrayers": MessageLookupByLibrary.simpleMessage("الصلوات"),
    "calendarStreamRetry": MessageLookupByLibrary.simpleMessage(
      "سيتم إعادة المحاولة تلقائيًا",
    ),
    "endOfDayBody": MessageLookupByLibrary.simpleMessage(
      "هل أتممت صلواتك اليوم؟",
    ),
    "endOfDayTitle": MessageLookupByLibrary.simpleMessage("تذكير يومي"),
    "errorLoadingCalendar": MessageLookupByLibrary.simpleMessage(
      "فشل تحميل التقويم",
    ),
    "errorLoadingData": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل البيانات",
    ),
    "errorLoadingSettings": MessageLookupByLibrary.simpleMessage(
      "فشل تحميل الإعدادات",
    ),
    "errorRetry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "historyEditWarningBody": MessageLookupByLibrary.simpleMessage(
      "تغيير السجلات السابقة قد يؤثر على السلسلة والنقاط.",
    ),
    "historyEditWarningTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل التاريخ؟",
    ),
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "navToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "notificationBody": m2,
    "notificationTitle": m3,
    "offsetMinutes": m4,
    "onboardingAppLockBody": MessageLookupByLibrary.simpleMessage(
      "أمّن سجل صلاتك ببصمة أو رمز PIN.",
    ),
    "onboardingAppLockTitle": MessageLookupByLibrary.simpleMessage(
      "احمِ خصوصيتك",
    ),
    "onboardingBack": MessageLookupByLibrary.simpleMessage("رجوع"),
    "onboardingConfirmBody": MessageLookupByLibrary.simpleMessage(
      "راجع إعداداتك وابدأ التتبع.",
    ),
    "onboardingConfirmTitle": MessageLookupByLibrary.simpleMessage("أنت جاهز"),
    "onboardingEnableAppLock": MessageLookupByLibrary.simpleMessage(
      "تفعيل قفل التطبيق",
    ),
    "onboardingEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "تفعيل الإشعارات",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
    "onboardingMaybeLater": MessageLookupByLibrary.simpleMessage("ربما لاحقاً"),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("التالي"),
    "onboardingNotificationsBody": MessageLookupByLibrary.simpleMessage(
      "هل تريد تذكيرات لطيفة؟",
    ),
    "onboardingNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "ابقَ على المسار",
    ),
    "onboardingPrayerTimesBody": MessageLookupByLibrary.simpleMessage(
      "قم بتعيين وقت بدء كل صلاة.",
    ),
    "onboardingPrayerTimesTitle": MessageLookupByLibrary.simpleMessage(
      "حدد مواعيد الصلاة",
    ),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "تتبع صلواتك اليومية مع تذكيرات لطيفة.",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "مرحباً بك في سجل الصلاة",
    ),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("العصر"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("الظهر"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("الفجر"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("العشاء"),
    "prayerJumuah": MessageLookupByLibrary.simpleMessage("الجمعة"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("المغرب"),
    "securityBiometricReason": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق لفتح سجل الصلاة",
    ),
    "securityConfirmPinLabel": MessageLookupByLibrary.simpleMessage(
      "تأكيد رمز PIN",
    ),
    "securityPinDigitsError": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتكون رمز PIN من 4 أرقام",
    ),
    "securityPinLabel": MessageLookupByLibrary.simpleMessage("رمز PIN"),
    "securityPinMismatchError": MessageLookupByLibrary.simpleMessage(
      "رمزا PIN غير متطابقين",
    ),
    "securitySetPinTitle": MessageLookupByLibrary.simpleMessage(
      "عيّن رمز PIN مكوّن من 4 أرقام",
    ),
    "securityUnlockTitle": MessageLookupByLibrary.simpleMessage(
      "افتح سجل الصلاة",
    ),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("حول"),
    "settingsAppLock": MessageLookupByLibrary.simpleMessage("قفل التطبيق"),
    "settingsAppLockSubtitle": MessageLookupByLibrary.simpleMessage(
      "طلب فتح القفل بعد إطفاء الشاشة",
    ),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("المظهر"),
    "settingsBadges": MessageLookupByLibrary.simpleMessage("الشارات"),
    "settingsBadgesSubtitle": MessageLookupByLibrary.simpleMessage(
      "عرض إنجازاتك التحفيزية",
    ),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("الاهتزاز اللمسي"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "اهتزاز عند التفاعل",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("اللغة"),
    "settingsLanguageArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "settingsLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "settingsNotificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "تفعيل تنبيهات أوقات الصلاة",
    ),
    "settingsPrayerSchedule": MessageLookupByLibrary.simpleMessage(
      "مواعيد الصلاة",
    ),
    "settingsPrayerScheduleSubtitle": MessageLookupByLibrary.simpleMessage(
      "ضبط مواعيد الصلاة يدويًا",
    ),
    "settingsPreferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "سياسة الخصوصية",
    ),
    "settingsReminderOffset": MessageLookupByLibrary.simpleMessage(
      "وقت التنبيه",
    ),
    "settingsReminderOffsetSubtitle": MessageLookupByLibrary.simpleMessage(
      "تعديل وقت الإشعار",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage("إظهار النقاط"),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "عرض النقاط في الواجهة",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("السمة"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("داكن"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("النظام"),
    "settingsWeekStart": MessageLookupByLibrary.simpleMessage("بداية الأسبوع"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("انقر للتسجيل"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "جميع الصلوات مكتملة!",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "استمر، أنت تبلي حسنًا!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage(
      "لم يتم تسجيل أي صلاة بعد",
    ),
    "todayPartial": m5,
    "todayPoints": m6,
    "todayProgress": MessageLookupByLibrary.simpleMessage("تقدم اليوم"),
    "todayStreak": m7,
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("الاثنين"),
    "weekStartSaturday": MessageLookupByLibrary.simpleMessage("السبت"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("الأحد"),
  };
}
