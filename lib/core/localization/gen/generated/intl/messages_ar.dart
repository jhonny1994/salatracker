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

  static String m0(count) => "${count} من 5 صلوات مسجلة";

  static String m1(count) => "${count} نقطة";

  static String m2(count) => "سلسلة ${count} يوم";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("سجل الصلاة"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "navToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("العصر"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("الظهر"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("الفجر"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("العشاء"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("المغرب"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("انقر للتسجيل"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "جميع الصلوات مكتملة!",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "استمر، أنت تبلي حسنًا!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage(
      "لم يتم تسجيل أي صلاة بعد",
    ),
    "todayPartial": m0,
    "todayPoints": m1,
    "todayProgress": MessageLookupByLibrary.simpleMessage("تقدم اليوم"),
    "todayStreak": m2,
  };
}
