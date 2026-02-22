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

  static String m0(date) => "Obtenu le ${date}";

  static String m1(completed, total) => "${completed}/${total}";

  static String m2(time) => "Enregistré à ${time}";

  static String m3(prayer) => "C\'est l\'heure de la prière de ${prayer}";

  static String m4(prayer) => "L\'heure de ${prayer}";

  static String m5(minutes) => "${minutes} min";

  static String m6(seconds) => "Réessayez dans ${seconds}s";

  static String m7(completed, total) => "${completed}/${total}";

  static String m8(count) => "${count} sur 5 prières enregistrées";

  static String m9(count) => "${count} points";

  static String m10(count) => "Série de ${count} jours";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "actionContinue": MessageLookupByLibrary.simpleMessage("Continuer"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Salat Tracker"),
    "badgeFirstPrayerDescription": MessageLookupByLibrary.simpleMessage(
      "Vous avez enregistré votre première prière.",
    ),
    "badgeFirstPrayerName": MessageLookupByLibrary.simpleMessage(
      "Première prière enregistrée",
    ),
    "badgeMonthCompleteDescription": MessageLookupByLibrary.simpleMessage(
      "90% de complétion atteints sur un mois.",
    ),
    "badgeMonthCompleteName": MessageLookupByLibrary.simpleMessage(
      "Mois accompli",
    ),
    "badgeSeasonChampionDescription": MessageLookupByLibrary.simpleMessage(
      "80% de complétion atteints sur 3 mois.",
    ),
    "badgeSeasonChampionName": MessageLookupByLibrary.simpleMessage(
      "Champion de saison",
    ),
    "badgeWeekConsistencyDescription": MessageLookupByLibrary.simpleMessage(
      "7 jours complets de prières validés.",
    ),
    "badgeWeekConsistencyName": MessageLookupByLibrary.simpleMessage(
      "Semaine de régularité",
    ),
    "badgesEarnedOn": m0,
    "badgesEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun badge pour le moment. Continuez vos prières.",
    ),
    "badgesTitle": MessageLookupByLibrary.simpleMessage("Badges"),
    "calendarCompleted": MessageLookupByLibrary.simpleMessage("Complété"),
    "calendarCompletionRatio": m1,
    "calendarLoggedAt": m2,
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
    "endOfDayBody": MessageLookupByLibrary.simpleMessage(
      "Avez-vous terminé toutes vos prières aujourd\'hui ?",
    ),
    "endOfDayTitle": MessageLookupByLibrary.simpleMessage(
      "Réflexion quotidienne",
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
    "generalNo": MessageLookupByLibrary.simpleMessage("Désactivé"),
    "generalYes": MessageLookupByLibrary.simpleMessage("Activé"),
    "historyEditWarningBody": MessageLookupByLibrary.simpleMessage(
      "La modification des enregistrements passés peut affecter votre série et vos points.",
    ),
    "historyEditWarningTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'historique ?",
    ),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendrier"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "navToday": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "notificationBody": m3,
    "notificationChannelDescription": MessageLookupByLibrary.simpleMessage(
      "Notifications pour les horaires de prière",
    ),
    "notificationChannelName": MessageLookupByLibrary.simpleMessage(
      "Notifications de prière",
    ),
    "notificationTitle": m4,
    "offsetMinutes": m5,
    "onboardingAppLockBody": MessageLookupByLibrary.simpleMessage(
      "Sécurisez votre journal de prière avec biométrie ou PIN.",
    ),
    "onboardingAppLockTitle": MessageLookupByLibrary.simpleMessage(
      "Protégez Votre Vie Privée",
    ),
    "onboardingBack": MessageLookupByLibrary.simpleMessage("Retour"),
    "onboardingConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Vérifiez vos paramètres et commencez.",
    ),
    "onboardingConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Vous êtes Prêt",
    ),
    "onboardingEnableAppLock": MessageLookupByLibrary.simpleMessage(
      "Activer le Verrouillage",
    ),
    "onboardingEnableLocation": MessageLookupByLibrary.simpleMessage(
      "Activer la position",
    ),
    "onboardingEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Activer les Notifications",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("Commencer"),
    "onboardingLocationBody": MessageLookupByLibrary.simpleMessage(
      "Autorisez l\'accès à la position pour déterminer avec précision votre ville et fuseau horaire pour les horaires de prière.",
    ),
    "onboardingLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Détectez votre position",
    ),
    "onboardingMaybeLater": MessageLookupByLibrary.simpleMessage("Plus tard"),
    "onboardingNext": MessageLookupByLibrary.simpleMessage("Suivant"),
    "onboardingNotificationsBody": MessageLookupByLibrary.simpleMessage(
      "Souhaitez-vous des rappels amicaux ?",
    ),
    "onboardingNotificationsTitle": MessageLookupByLibrary.simpleMessage(
      "Restez sur la Bonne Voie",
    ),
    "onboardingPrayerTimesBody": MessageLookupByLibrary.simpleMessage(
      "Configurez l\'heure de début de chaque prière.",
    ),
    "onboardingPrayerTimesTitle": MessageLookupByLibrary.simpleMessage(
      "Définissez vos Horaires",
    ),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("Passer"),
    "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "Suivez vos prières quotidiennes avec des rappels doux.",
    ),
    "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Bienvenue sur Salat Tracker",
    ),
    "prayerAsr": MessageLookupByLibrary.simpleMessage("Asr"),
    "prayerDhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "prayerFajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "prayerIsha": MessageLookupByLibrary.simpleMessage("Isha"),
    "prayerJumuah": MessageLookupByLibrary.simpleMessage("Jumu\'ah"),
    "prayerMaghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "routerError": MessageLookupByLibrary.simpleMessage("Erreur de route"),
    "securityBiometricReason": MessageLookupByLibrary.simpleMessage(
      "Authentifiez-vous pour déverrouiller Salat Tracker",
    ),
    "securityConfirmPinLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmer le PIN",
    ),
    "securityCurrentPinError": MessageLookupByLibrary.simpleMessage(
      "Le PIN actuel est incorrect",
    ),
    "securityCurrentPinLabel": MessageLookupByLibrary.simpleMessage(
      "PIN actuel",
    ),
    "securityCurrentPinTitle": MessageLookupByLibrary.simpleMessage(
      "Entrez le PIN actuel",
    ),
    "securityLockoutSeconds": m6,
    "securityPinDigitsError": MessageLookupByLibrary.simpleMessage(
      "Le PIN doit contenir exactement 6 chiffres",
    ),
    "securityPinLabel": MessageLookupByLibrary.simpleMessage("PIN"),
    "securityPinMismatchError": MessageLookupByLibrary.simpleMessage(
      "Les PIN ne correspondent pas",
    ),
    "securitySetPinTitle": MessageLookupByLibrary.simpleMessage(
      "Définir un PIN à 6 chiffres",
    ),
    "securityUnlockTitle": MessageLookupByLibrary.simpleMessage(
      "Déverrouiller Salat Tracker",
    ),
    "settingsAbout": MessageLookupByLibrary.simpleMessage("À propos"),
    "settingsAppLock": MessageLookupByLibrary.simpleMessage(
      "Verrouillage de l\'app",
    ),
    "settingsAppLockSubtitle": MessageLookupByLibrary.simpleMessage(
      "Exiger un déverrouillage après écran éteint",
    ),
    "settingsAppVersion": MessageLookupByLibrary.simpleMessage(
      "Version de l\'Application",
    ),
    "settingsAppearance": MessageLookupByLibrary.simpleMessage("Apparence"),
    "settingsBadges": MessageLookupByLibrary.simpleMessage("Badges"),
    "settingsBadgesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Voir les jalons réflexifs",
    ),
    "settingsBiometricUnlock": MessageLookupByLibrary.simpleMessage(
      "Déverrouillage biométrique",
    ),
    "settingsBiometricUnlockSubtitle": MessageLookupByLibrary.simpleMessage(
      "Utiliser la biométrie avant le PIN sur l\'écran verrouillé",
    ),
    "settingsBiometricUnlockUnavailable": MessageLookupByLibrary.simpleMessage(
      "Biométrie indisponible sur cet appareil",
    ),
    "settingsCurrentTimezone": MessageLookupByLibrary.simpleMessage(
      "Fuseau horaire actuel",
    ),
    "settingsCurrentTimezoneUnavailable": MessageLookupByLibrary.simpleMessage(
      "Fuseau horaire indisponible",
    ),
    "settingsHaptics": MessageLookupByLibrary.simpleMessage("Retour Haptique"),
    "settingsHapticsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Vibrer aux interactions",
    ),
    "settingsLanguage": MessageLookupByLibrary.simpleMessage("Langue"),
    "settingsLanguageArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "settingsLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "settingsLanguageFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "settingsNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "settingsNotificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Activer les alertes de prière",
    ),
    "settingsPrayerSchedule": MessageLookupByLibrary.simpleMessage(
      "Horaires de prière",
    ),
    "settingsPrayerScheduleSubtitle": MessageLookupByLibrary.simpleMessage(
      "Définir les horaires manuellement",
    ),
    "settingsPreferences": MessageLookupByLibrary.simpleMessage("Préférences"),
    "settingsPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Politique de Confidentialité",
    ),
    "settingsReminderOffset": MessageLookupByLibrary.simpleMessage(
      "Décalage du rappel",
    ),
    "settingsReminderOffsetSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ajuster l\'heure de notification",
    ),
    "settingsResetPin": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le PIN",
    ),
    "settingsResetPinSubtitle": MessageLookupByLibrary.simpleMessage(
      "Définir un nouveau PIN de verrouillage",
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
    "settingsVersionLoading": MessageLookupByLibrary.simpleMessage(
      "Chargement...",
    ),
    "settingsWeekStart": MessageLookupByLibrary.simpleMessage(
      "Début de la semaine",
    ),
    "tapToLog": MessageLookupByLibrary.simpleMessage(
      "Appuyez pour enregistrer",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
    "todayComplete": MessageLookupByLibrary.simpleMessage(
      "Toutes les prières complétées !",
    ),
    "todayCompletionRatio": m7,
    "todayEncouragement": MessageLookupByLibrary.simpleMessage(
      "Continuez, vous êtes formidable !",
    ),
    "todayNone": MessageLookupByLibrary.simpleMessage(
      "Aucune prière enregistrée",
    ),
    "todayPartial": m8,
    "todayPoints": m9,
    "todayProgress": MessageLookupByLibrary.simpleMessage(
      "Progrès d\'aujourd\'hui",
    ),
    "todayStreak": m10,
    "weekStartMonday": MessageLookupByLibrary.simpleMessage("Lundi"),
    "weekStartSaturday": MessageLookupByLibrary.simpleMessage("Samedi"),
    "weekStartSunday": MessageLookupByLibrary.simpleMessage("Dimanche"),
  };
}
