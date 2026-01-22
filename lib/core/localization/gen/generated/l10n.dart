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

  /// `الجمعة`
  String get prayerJumuah {
    return Intl.message('الجمعة', name: 'prayerJumuah', desc: '', args: []);
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

  /// `المظهر`
  String get settingsAppearance {
    return Intl.message(
      'المظهر',
      name: 'settingsAppearance',
      desc: '',
      args: [],
    );
  }

  /// `السمة`
  String get settingsTheme {
    return Intl.message('السمة', name: 'settingsTheme', desc: '', args: []);
  }

  /// `فاتح`
  String get settingsThemeLight {
    return Intl.message('فاتح', name: 'settingsThemeLight', desc: '', args: []);
  }

  /// `داكن`
  String get settingsThemeDark {
    return Intl.message('داكن', name: 'settingsThemeDark', desc: '', args: []);
  }

  /// `النظام`
  String get settingsThemeSystem {
    return Intl.message(
      'النظام',
      name: 'settingsThemeSystem',
      desc: '',
      args: [],
    );
  }

  /// `اللغة`
  String get settingsLanguage {
    return Intl.message('اللغة', name: 'settingsLanguage', desc: '', args: []);
  }

  /// `English`
  String get settingsLanguageEnglish {
    return Intl.message(
      'English',
      name: 'settingsLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get settingsLanguageArabic {
    return Intl.message(
      'العربية',
      name: 'settingsLanguageArabic',
      desc: '',
      args: [],
    );
  }

  /// `Français`
  String get settingsLanguageFrench {
    return Intl.message(
      'Français',
      name: 'settingsLanguageFrench',
      desc: '',
      args: [],
    );
  }

  /// `التفضيلات`
  String get settingsPreferences {
    return Intl.message(
      'التفضيلات',
      name: 'settingsPreferences',
      desc: '',
      args: [],
    );
  }

  /// `الإشعارات`
  String get settingsNotifications {
    return Intl.message(
      'الإشعارات',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل تنبيهات أوقات الصلاة`
  String get settingsNotificationsSubtitle {
    return Intl.message(
      'تفعيل تنبيهات أوقات الصلاة',
      name: 'settingsNotificationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `الاهتزاز اللمسي`
  String get settingsHaptics {
    return Intl.message(
      'الاهتزاز اللمسي',
      name: 'settingsHaptics',
      desc: '',
      args: [],
    );
  }

  /// `اهتزاز عند التفاعل`
  String get settingsHapticsSubtitle {
    return Intl.message(
      'اهتزاز عند التفاعل',
      name: 'settingsHapticsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `إظهار النقاط`
  String get settingsShowPoints {
    return Intl.message(
      'إظهار النقاط',
      name: 'settingsShowPoints',
      desc: '',
      args: [],
    );
  }

  /// `عرض النقاط في الواجهة`
  String get settingsShowPointsSubtitle {
    return Intl.message(
      'عرض النقاط في الواجهة',
      name: 'settingsShowPointsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `حول`
  String get settingsAbout {
    return Intl.message('حول', name: 'settingsAbout', desc: '', args: []);
  }

  /// `إصدار التطبيق`
  String get settingsAppVersion {
    return Intl.message(
      'إصدار التطبيق',
      name: 'settingsAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `سياسة الخصوصية`
  String get settingsPrivacyPolicy {
    return Intl.message(
      'سياسة الخصوصية',
      name: 'settingsPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `مواعيد الصلاة`
  String get settingsPrayerSchedule {
    return Intl.message(
      'مواعيد الصلاة',
      name: 'settingsPrayerSchedule',
      desc: '',
      args: [],
    );
  }

  /// `ضبط مواعيد الصلاة يدويًا`
  String get settingsPrayerScheduleSubtitle {
    return Intl.message(
      'ضبط مواعيد الصلاة يدويًا',
      name: 'settingsPrayerScheduleSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `فشل تحميل الإعدادات`
  String get errorLoadingSettings {
    return Intl.message(
      'فشل تحميل الإعدادات',
      name: 'errorLoadingSettings',
      desc: '',
      args: [],
    );
  }

  /// `إعادة المحاولة`
  String get errorRetry {
    return Intl.message(
      'إعادة المحاولة',
      name: 'errorRetry',
      desc: '',
      args: [],
    );
  }

  /// `فشل تحميل التقويم`
  String get errorLoadingCalendar {
    return Intl.message(
      'فشل تحميل التقويم',
      name: 'errorLoadingCalendar',
      desc: '',
      args: [],
    );
  }

  /// `سيتم إعادة المحاولة تلقائيًا`
  String get calendarStreamRetry {
    return Intl.message(
      'سيتم إعادة المحاولة تلقائيًا',
      name: 'calendarStreamRetry',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد صلوات مسجلة لهذا اليوم`
  String get calendarNoData {
    return Intl.message(
      'لا توجد صلوات مسجلة لهذا اليوم',
      name: 'calendarNoData',
      desc: '',
      args: [],
    );
  }

  /// `مكتمل`
  String get calendarCompleted {
    return Intl.message('مكتمل', name: 'calendarCompleted', desc: '', args: []);
  }

  /// `النقاط`
  String get calendarPoints {
    return Intl.message('النقاط', name: 'calendarPoints', desc: '', args: []);
  }

  /// `الصلوات`
  String get calendarPrayers {
    return Intl.message('الصلوات', name: 'calendarPrayers', desc: '', args: []);
  }

  /// `لا توجد صلوات مسجلة`
  String get calendarNoPrayers {
    return Intl.message(
      'لا توجد صلوات مسجلة',
      name: 'calendarNoPrayers',
      desc: '',
      args: [],
    );
  }

  /// `سُجِّل في {time}`
  String calendarLoggedAt(String time) {
    return Intl.message(
      'سُجِّل في $time',
      name: 'calendarLoggedAt',
      desc: '',
      args: [time],
    );
  }

  /// `اليوم`
  String get today {
    return Intl.message('اليوم', name: 'today', desc: '', args: []);
  }

  /// `خطأ في تحميل البيانات`
  String get errorLoadingData {
    return Intl.message(
      'خطأ في تحميل البيانات',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }

  /// `تعديل التاريخ؟`
  String get historyEditWarningTitle {
    return Intl.message(
      'تعديل التاريخ؟',
      name: 'historyEditWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `تغيير السجلات السابقة قد يؤثر على السلسلة والنقاط.`
  String get historyEditWarningBody {
    return Intl.message(
      'تغيير السجلات السابقة قد يؤثر على السلسلة والنقاط.',
      name: 'historyEditWarningBody',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء`
  String get actionCancel {
    return Intl.message('إلغاء', name: 'actionCancel', desc: '', args: []);
  }

  /// `استمرار`
  String get actionContinue {
    return Intl.message('استمرار', name: 'actionContinue', desc: '', args: []);
  }

  /// `وقت التنبيه`
  String get settingsReminderOffset {
    return Intl.message(
      'وقت التنبيه',
      name: 'settingsReminderOffset',
      desc: '',
      args: [],
    );
  }

  /// `تعديل وقت الإشعار`
  String get settingsReminderOffsetSubtitle {
    return Intl.message(
      'تعديل وقت الإشعار',
      name: 'settingsReminderOffsetSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} دقيقة`
  String offsetMinutes(Object minutes) {
    return Intl.message(
      '$minutes دقيقة',
      name: 'offsetMinutes',
      desc: '',
      args: [minutes],
    );
  }

  /// `بداية الأسبوع`
  String get settingsWeekStart {
    return Intl.message(
      'بداية الأسبوع',
      name: 'settingsWeekStart',
      desc: '',
      args: [],
    );
  }

  /// `الأحد`
  String get weekStartSunday {
    return Intl.message('الأحد', name: 'weekStartSunday', desc: '', args: []);
  }

  /// `الاثنين`
  String get weekStartMonday {
    return Intl.message('الاثنين', name: 'weekStartMonday', desc: '', args: []);
  }

  /// `السبت`
  String get weekStartSaturday {
    return Intl.message('السبت', name: 'weekStartSaturday', desc: '', args: []);
  }

  /// `وقت {prayer}`
  String notificationTitle(Object prayer) {
    return Intl.message(
      'وقت $prayer',
      name: 'notificationTitle',
      desc: '',
      args: [prayer],
    );
  }

  /// `حان الآن وقت صلاة {prayer}`
  String notificationBody(Object prayer) {
    return Intl.message(
      'حان الآن وقت صلاة $prayer',
      name: 'notificationBody',
      desc: '',
      args: [prayer],
    );
  }

  /// `تذكير يومي`
  String get endOfDayTitle {
    return Intl.message(
      'تذكير يومي',
      name: 'endOfDayTitle',
      desc: '',
      args: [],
    );
  }

  /// `هل أتممت صلواتك اليوم؟`
  String get endOfDayBody {
    return Intl.message(
      'هل أتممت صلواتك اليوم؟',
      name: 'endOfDayBody',
      desc: '',
      args: [],
    );
  }

  /// `مرحباً بك في سجل الصلاة`
  String get onboardingWelcomeTitle {
    return Intl.message(
      'مرحباً بك في سجل الصلاة',
      name: 'onboardingWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `تتبع صلواتك اليومية مع تذكيرات لطيفة.`
  String get onboardingWelcomeBody {
    return Intl.message(
      'تتبع صلواتك اليومية مع تذكيرات لطيفة.',
      name: 'onboardingWelcomeBody',
      desc: '',
      args: [],
    );
  }

  /// `حدد مواعيد الصلاة`
  String get onboardingPrayerTimesTitle {
    return Intl.message(
      'حدد مواعيد الصلاة',
      name: 'onboardingPrayerTimesTitle',
      desc: '',
      args: [],
    );
  }

  /// `قم بتعيين وقت بدء كل صلاة.`
  String get onboardingPrayerTimesBody {
    return Intl.message(
      'قم بتعيين وقت بدء كل صلاة.',
      name: 'onboardingPrayerTimesBody',
      desc: '',
      args: [],
    );
  }

  /// `ابقَ على المسار`
  String get onboardingNotificationsTitle {
    return Intl.message(
      'ابقَ على المسار',
      name: 'onboardingNotificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد تذكيرات لطيفة؟`
  String get onboardingNotificationsBody {
    return Intl.message(
      'هل تريد تذكيرات لطيفة؟',
      name: 'onboardingNotificationsBody',
      desc: '',
      args: [],
    );
  }

  /// `احمِ خصوصيتك`
  String get onboardingAppLockTitle {
    return Intl.message(
      'احمِ خصوصيتك',
      name: 'onboardingAppLockTitle',
      desc: '',
      args: [],
    );
  }

  /// `أمّن سجل صلاتك ببصمة أو رمز PIN.`
  String get onboardingAppLockBody {
    return Intl.message(
      'أمّن سجل صلاتك ببصمة أو رمز PIN.',
      name: 'onboardingAppLockBody',
      desc: '',
      args: [],
    );
  }

  /// `أنت جاهز`
  String get onboardingConfirmTitle {
    return Intl.message(
      'أنت جاهز',
      name: 'onboardingConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع إعداداتك وابدأ التتبع.`
  String get onboardingConfirmBody {
    return Intl.message(
      'راجع إعداداتك وابدأ التتبع.',
      name: 'onboardingConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `تخطي`
  String get onboardingSkip {
    return Intl.message('تخطي', name: 'onboardingSkip', desc: '', args: []);
  }

  /// `التالي`
  String get onboardingNext {
    return Intl.message('التالي', name: 'onboardingNext', desc: '', args: []);
  }

  /// `رجوع`
  String get onboardingBack {
    return Intl.message('رجوع', name: 'onboardingBack', desc: '', args: []);
  }

  /// `ابدأ الآن`
  String get onboardingGetStarted {
    return Intl.message(
      'ابدأ الآن',
      name: 'onboardingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل الإشعارات`
  String get onboardingEnableNotifications {
    return Intl.message(
      'تفعيل الإشعارات',
      name: 'onboardingEnableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل قفل التطبيق`
  String get onboardingEnableAppLock {
    return Intl.message(
      'تفعيل قفل التطبيق',
      name: 'onboardingEnableAppLock',
      desc: '',
      args: [],
    );
  }

  /// `ربما لاحقاً`
  String get onboardingMaybeLater {
    return Intl.message(
      'ربما لاحقاً',
      name: 'onboardingMaybeLater',
      desc: '',
      args: [],
    );
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
