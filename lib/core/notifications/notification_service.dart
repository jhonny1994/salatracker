import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

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
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));

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
      initSettings,
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
      return result ?? false;
    } else if (Platform.isAndroid) {
      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidImplementation != null) {
        final granted = await androidImplementation
            .requestNotificationsPermission();
        return granted ?? false;
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
    String? payload,
  }) async {
    if (!_initialized) await initialize();

    // Ensure scheduled time is in the future
    if (scheduledAt.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledAt, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          channelDescription: 'Notifications for prayer times',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  /// Cancels all scheduled notifications.
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
