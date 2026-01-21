// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(count) => "${count} sur 5 prières enregistrées";

  static String m1(count) => "${count} points";

  static String m2(count) => "Série de ${count} jours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendrier"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "navToday": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("Asr"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("Isha"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "tapToLog": MessageLookupByLibrary.simpleMessage(
      "Appuyez pour enregistrer",
    ),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "Toutes les prières complétées !",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Continuez, vous êtes formidable !",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage(
      "Aucune prière enregistrée",
    ),
    "todayPartial": m0,
    "todayPoints": m1,
    "todayProgress": MessageLookupByLibrary.simpleMessage(
      "Progrès d\'aujourd\'hui",
    ),
    "todayStreak": m2,
  };
}
