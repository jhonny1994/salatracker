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

  static String m0(count) => "${count} of 5 prayers logged";

  static String m1(count) => "${count} points";

  static String m2(count) => "${count} day streak";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "navToday": MessageLookupByLibrary.simpleMessage("Today"),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("Asr"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("Isha"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "tapToLog": MessageLookupByLibrary.simpleMessage("Tap to log"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "All prayers completed!",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Keep going, you\'re doing great!",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage("No prayers logged yet"),
    "todayPartial": m0,
    "todayPoints": m1,
    "todayProgress": MessageLookupByLibrary.simpleMessage("Today\'s Progress"),
    "todayStreak": m2,
  };
}
