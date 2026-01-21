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

  static String m0(time) => "Enregistré à ${time}";

  static String m1(count) => "${count} sur 5 prières enregistrées";

  static String m2(count) => "${count} points";

  static String m3(count) => "Série de ${count} jours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("Complété"),
    "calendarLoggedAt": m0,
    "calendarNoData": MessageLookupByLibrary.simpleMessage(
      "Aucune prière enregistrée pour ce jour",
    ),
    "calendarNoPrayers": MessageLookupByLibrary.simpleMessage(
      "Aucune prière enregistrée",
    ),
    "calendarPoints": MessageLookupByLibrary.simpleMessage("Points"),
    "calendarPrayers": MessageLookupByLibrary.simpleMessage("Prières"),
    "calendarStreamRetry": MessageLookupByLibrary.simpleMessage(
      "Nouvelle tentative automatique",
    ),
    "errorLoadingCalendar": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement du calendrier",
    ),
    "errorLoadingData": MessageLookupByLibrary.simpleMessage(
      "Erreur de chargement des données",
    ),
    "errorLoadingSettings": MessageLookupByLibrary.simpleMessage(
      "Échec du chargement des paramètres",
    ),
    "errorRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendrier"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "navToday": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("Asr"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("Isha"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("À propos"),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage(
      "Version de l\'Application",
    ),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Apparence"),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("Retour Haptique"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vibrer aux interactions",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Langue"),
    "settingsLanguageArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "settingsLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "settingsPreferences": MessageLookupByLibrary.simpleMessage("Préférences"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Politique de Confidentialité",
    ),
    "settingsShowPoints": MessageLookupByLibrary.simpleMessage(
      "Afficher les Points",
    ),
    "settingsShowPointsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Afficher les points dans l\'interface",
    ),
    "settingsTheme": MessageLookupByLibrary.simpleMessage("Thème"),
    "settingsThemeDark": MessageLookupByLibrary.simpleMessage("Sombre"),
    "settingsThemeLight": MessageLookupByLibrary.simpleMessage("Clair"),
    "settingsThemeSystem": MessageLookupByLibrary.simpleMessage("Système"),
    "tapToLog": MessageLookupByLibrary.simpleMessage(
      "Appuyez pour enregistrer",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "Toutes les prières complétées !",
    ),
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Continuez, vous êtes formidable !",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage(
      "Aucune prière enregistrée",
    ),
    "todayPartial": m1,
    "todayPoints": m2,
    "todayProgress": MessageLookupByLibrary.simpleMessage(
      "Progrès d\'aujourd\'hui",
    ),
    "todayStreak": m3,
  };
}
