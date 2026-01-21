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

  static String m0(time) => "سُجِّل في ${time}";

  static String m1(count) => "${count} من 5 صلوات مسجلة";

  static String m2(count) => "${count} نقطة";

  static String m3(count) => "سلسلة ${count} يوم";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("سجل الصلاة"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "calendarLoggedAt": m0,
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
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "navToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("العصر"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("الظهر"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("الفجر"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("العشاء"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("المغرب"),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("حول"),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("المظهر"),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("الاهتزاز اللمسي"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "اهتزاز عند التفاعل",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("اللغة"),
    "settingsLanguageArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "settingsLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "settingsPreferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "سياسة الخصوصية",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage("إظهار النقاط"),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "عرض النقاط في الواجهة",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("السمة"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("داكن"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("فاتح"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("النظام"),
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
    "todayPartial": m1,
    "todayPoints": m2,
    "todayProgress": MessageLookupByLibrary.simpleMessage("تقدم اليوم"),
    "todayStreak": m3,
  };
}
