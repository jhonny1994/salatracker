// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `سجل الصلاة`
  String get appTitle {
    return Intl.message('سجل الصلاة', name: 'appTitle', desc: '', args: []);
  }

  /// `اليوم`
  String get navToday {
    return Intl.message('اليوم', name: 'navToday', desc: '', args: []);
  }

  /// `التقويم`
  String get navCalendar {
    return Intl.message('التقويم', name: 'navCalendar', desc: '', args: []);
  }

  /// `الإعدادات`
  String get navSettings {
    return Intl.message('الإعدادات', name: 'navSettings', desc: '', args: []);
  }

  /// `الفجر`
  String get prayerFajr {
    return Intl.message('الفجر', name: 'prayerFajr', desc: '', args: []);
  }

  /// `الظهر`
  String get prayerDhuhr {
    return Intl.message('الظهر', name: 'prayerDhuhr', desc: '', args: []);
  }

  /// `العصر`
  String get prayerAsr {
    return Intl.message('العصر', name: 'prayerAsr', desc: '', args: []);
  }

  /// `المغرب`
  String get prayerMaghrib {
    return Intl.message('المغرب', name: 'prayerMaghrib', desc: '', args: []);
  }

  /// `العشاء`
  String get prayerIsha {
    return Intl.message('العشاء', name: 'prayerIsha', desc: '', args: []);
  }

  /// `تقدم اليوم`
  String get todayProgress {
    return Intl.message(
      'تقدم اليوم',
      name: 'todayProgress',
      desc: '',
      args: [],
    );
  }

  /// `جميع الصلوات مكتملة!`
  String get todayComplete {
    return Intl.message(
      'جميع الصلوات مكتملة!',
      name: 'todayComplete',
      desc: '',
      args: [],
    );
  }

  /// `{count} من 5 صلوات مسجلة`
  String todayPartial(int count) {
    return Intl.message(
      '$count من 5 صلوات مسجلة',
      name: 'todayPartial',
      desc: '',
      args: [count],
    );
  }

  /// `لم يتم تسجيل أي صلاة بعد`
  String get todayNone {
    return Intl.message(
      'لم يتم تسجيل أي صلاة بعد',
      name: 'todayNone',
      desc: '',
      args: [],
    );
  }

  /// `سلسلة {count} يوم`
  String todayStreak(int count) {
    return Intl.message(
      'سلسلة $count يوم',
      name: 'todayStreak',
      desc: '',
      args: [count],
    );
  }

  /// `{count} نقطة`
  String todayPoints(int count) {
    return Intl.message(
      '$count نقطة',
      name: 'todayPoints',
      desc: '',
      args: [count],
    );
  }

  /// `استمر، أنت تبلي حسنًا!`
  String get todayEncouragement {
    return Intl.message(
      'استمر، أنت تبلي حسنًا!',
      name: 'todayEncouragement',
      desc: '',
      args: [],
    );
  }

  /// `انقر للتسجيل`
  String get tapToLog {
    return Intl.message('انقر للتسجيل', name: 'tapToLog', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
