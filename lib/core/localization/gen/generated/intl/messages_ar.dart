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

  static String m1(completed, total) => "${completed}/${total}";

  static String m2(time) => "سُجِّل في ${time}";

  static String m3(prayer) => "حان الآن موعد صلاة ${prayer}";

  static String m4(prayer) => "وقت صلاة ${prayer}";

  static String m5(minutes) => "${minutes} دقيقة";

  static String m6(seconds) => "حاول مرة أخرى بعد ${seconds} ثانية";

  static String m7(completed, total) => "${completed}/${total}";

  static String m8(count) => "${count} من 5 صلوات مسجلة";

  static String m9(count) => "${count} نقطة";

  static String m10(count) => "سلسلة التزام: ${count} أيام";

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
      "حققت معدل التزام 80% أو أكثر لمدة 3 أشهر.",
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
    "calendarCompletionRatio": m1,
    "calendarLoggedAt": m2,
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
    "generalNo": MessageLookupByLibrary.simpleMessage("معطل"),
    "generalYes": MessageLookupByLibrary.simpleMessage("مفعل"),
    "historyEditWarningBody": MessageLookupByLibrary.simpleMessage(
      "تعديل سجلات الصلوات السابقة قد يؤثر على حساب السلسلة والنقاط الخاصة بك.",
    ),
    "historyEditWarningTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل السجلات السابقة؟",
    ),
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "navToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "notificationBody": m3,
    "notificationChannelDescription": MessageLookupByLibrary.simpleMessage(
      "إشعارات لمواقيت الصلاة",
    ),
    "notificationChannelName": MessageLookupByLibrary.simpleMessage(
      "إشعارات الصلاة",
    ),
    "notificationTitle": m4,
    "offsetMinutes": m5,
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
    "onboardingEnableLocation": MessageLookupByLibrary.simpleMessage(
      "تفعيل الموقع",
    ),
    "onboardingEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "تفعيل الإشعارات",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
    "onboardingLocationBody": MessageLookupByLibrary.simpleMessage(
      "اسمح بالوصول إلى موقعك لتحديد مدينتك ومنطقتك الزمنية بدقة لمواقيت الصلاة.",
    ),
    "onboardingLocationTitle": MessageLookupByLibrary.simpleMessage(
      "تحديد موقعك",
    ),
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
    "routerError": MessageLookupByLibrary.simpleMessage("خطأ في المسار"),
    "securityBiometricReason": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق لفتح سجل الصلاة",
    ),
    "securityConfirmPinLabel": MessageLookupByLibrary.simpleMessage(
      "تأكيد رمز PIN",
    ),
    "securityCurrentPinError": MessageLookupByLibrary.simpleMessage(
      "رمز PIN الحالي غير صحيح",
    ),
    "securityCurrentPinLabel": MessageLookupByLibrary.simpleMessage(
      "رمز PIN الحالي",
    ),
    "securityCurrentPinTitle": MessageLookupByLibrary.simpleMessage(
      "أدخل رمز PIN الحالي",
    ),
    "securityLockoutSeconds": m6,
    "securityPinDigitsError": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتكون رمز PIN من 6 أرقام",
    ),
    "securityPinLabel": MessageLookupByLibrary.simpleMessage("رمز PIN"),
    "securityPinMismatchError": MessageLookupByLibrary.simpleMessage(
      "رمزا PIN غير متطابقين",
    ),
    "securitySetPinTitle": MessageLookupByLibrary.simpleMessage(
      "عيّن رمز PIN مكوّن من 6 أرقام",
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
    "settingsBiometricUnlock": MessageLookupByLibrary.simpleMessage(
      "الفتح بالبصمة",
    ),
    "settingsBiometricUnlockSubtitle": MessageLookupByLibrary.simpleMessage(
      "استخدام بصمة الإصبع أو الوجه لفتح شاشة القفل",
    ),
    "settingsBiometricUnlockUnavailable": MessageLookupByLibrary.simpleMessage(
      "البصمة غير متاحة على هذا الجهاز",
    ),
    "settingsContactUs": MessageLookupByLibrary.simpleMessage("اتصل بنا"),
    "settingsContactUsSubtitle": MessageLookupByLibrary.simpleMessage(
      "تواصل معنا للحصول على الدعم أو إبداء رأيك",
    ),
    "settingsCurrentTimezone": MessageLookupByLibrary.simpleMessage(
      "المنطقة الزمنية الحالية",
    ),
    "settingsCurrentTimezoneUnavailable": MessageLookupByLibrary.simpleMessage(
      "المنطقة الزمنية غير متاحة",
    ),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("التفاعل اللمسي"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "تفعيل الاهتزاز عند التفاعل مع الأزرار",
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
    "settingsResetPin": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين رمز PIN",
    ),
    "settingsResetPinSubtitle": MessageLookupByLibrary.simpleMessage(
      "تعيين رمز PIN جديد لقفل التطبيق",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage("إظهار النقاط"),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "عرض النقاط في الواجهة",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("السمة"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("داكن"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("النظام"),
    "settingsVersionLoading": MessageLookupByLibrary.simpleMessage(
      "جار التحميل...",
    ),
    "settingsWeekStart": MessageLookupByLibrary.simpleMessage("بداية الأسبوع"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("اضغط للتسجيل"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "جميع الصلوات مكتملة!",
    ),
    "todayCompletionRatio": m7,
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "استمر، لقد أديت عملاً رائعاً!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage("لم تسجل أي صلاة بعد"),
    "todayPartial": m8,
    "todayPoints": m9,
    "todayProgress": MessageLookupByLibrary.simpleMessage("تقدم اليوم"),
    "todayStreak": m10,
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("الاثنين"),
    "weekStartSaturday": MessageLookupByLibrary.simpleMessage("السبت"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("الأحد"),
  };
}
