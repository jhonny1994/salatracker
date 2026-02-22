import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:salat_tracker/core/localization/gen/generated/l10n.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Service for handling local notifications.
///
/// Wraps [FlutterLocalNotificationsPlugin] to provide simple scheduling
/// for prayer times.
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  final StreamController<String?> _onNotificationClick =
      StreamController<String?>.broadcast();

  /// Stream of notification payloads when clicked.
  Stream<String?> get onNotificationClick => _onNotificationClick.stream;

  /// Initializes the notification service.
  ///
  /// Sets up timezone and platform-specific settings.
  Future<void> initialize() async {
    if (_initialized) return;

    // 1. Initialize Timezone
    await refreshTimezone();

    // 2. Initialize Plugin
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {
        _onNotificationClick.add(details.payload);
      },
    );

    _initialized = true;
  }

  /// Requests notification permissions from the user.
  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      final granted = result ?? false;
      return granted;
    } else if (Platform.isAndroid) {
      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidImplementation != null) {
        final granted = await androidImplementation
            .requestNotificationsPermission();
        final result = granted ?? false;
        return result;
      }
    }
    return false;
  }

  /// Schedules a prayer notification.
  Future<void> schedulePrayer({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    bool repeatsDaily = false,
    String? payload,
  }) async {
    if (!_initialized) {
      await initialize();
    }

    var target = scheduledAt;
    if (repeatsDaily) {
      while (target.isBefore(DateTime.now())) {
        target = target.add(const Duration(days: 1));
      }
    }

    // Ensure scheduled time is in the future
    if (target.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(target, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          S.current.notificationChannelName,
          channelDescription: S.current.notificationChannelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: repeatsDaily ? DateTimeComponents.time : null,
      payload: payload,
    );
  }

  Future<void> refreshTimezone({String? preferredTimezoneId}) async {
    tz.initializeTimeZones();
    Object timeZoneData;
    try {
      timeZoneData = await FlutterTimezone.getLocalTimezone();
    } on Object {
      tz.setLocalLocation(tz.getLocation('UTC'));
      return;
    }

    final candidates = _timezoneCandidates(
      timeZoneData,
      preferredTimezoneId: preferredTimezoneId,
    );
    for (final zone in candidates) {
      try {
        tz.setLocalLocation(tz.getLocation(zone));
        return;
      } on Object {
        // Continue trying fallback candidates.
      }
    }

    tz.setLocalLocation(tz.getLocation('UTC'));
  }

  List<String> _timezoneCandidates(
    Object value, {
    String? preferredTimezoneId,
  }) {
    final direct = value.toString().trim();
    final list = <String>[];

    void add(String candidate) {
      final normalized = candidate.trim();
      if (normalized.isEmpty) {
        return;
      }
      if (!list.contains(normalized)) {
        list.add(normalized);
      }
    }

    if (preferredTimezoneId != null && preferredTimezoneId.trim().isNotEmpty) {
      add(preferredTimezoneId);
    }

    add(direct);

    final infoMatch = RegExp(r'TimezoneInfo\(([^,]+),').firstMatch(direct);
    if (infoMatch != null) {
      add(infoMatch.group(1)!);
    }

    add('UTC');
    return list;
  }

  /// Cancels all scheduled notifications.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
