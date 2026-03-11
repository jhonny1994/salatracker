import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:salat_tracker/features/prayer/prayer.dart';

part 'notification_intent.freezed.dart';
part 'notification_intent.g.dart';

enum NotificationIntentType {
  prayerReminder,
  dailyCheckinReminder,
  requiredUpdate,
  badgeUnlocked,
  genericFallback,
}

@freezed
abstract class NotificationIntent with _$NotificationIntent {
  const factory NotificationIntent({
    required int v,
    required NotificationIntentType type,
    required String intentId,
    PrayerType? prayerType,
    String? dateIso,
    String? scheduledAtIso,
    String? sourceNotificationId,
    String? sentAtIso,
  }) = _NotificationIntent;
  factory NotificationIntent.fromPayload(String payload) {
    try {
      final decoded = jsonDecode(payload);
      if (decoded is! Map<String, dynamic>) {
        return NotificationIntent.fallback(payload);
      }
      final parsed = NotificationIntent.fromJson(decoded);
      if (parsed.v != currentVersion) {
        return NotificationIntent.fallback(payload);
      }
      return parsed;
    } on Object {
      return NotificationIntent.fallback(payload);
    }
  }

  factory NotificationIntent.prayer({
    required String intentId,
    required PrayerType prayerType,
    required DateTime date,
    required DateTime scheduledAt,
    required int sourceNotificationId,
  }) {
    return NotificationIntent(
      v: currentVersion,
      type: NotificationIntentType.prayerReminder,
      intentId: intentId,
      prayerType: prayerType,
      dateIso: date.toIso8601String(),
      scheduledAtIso: scheduledAt.toIso8601String(),
      sourceNotificationId: '$sourceNotificationId',
      sentAtIso: DateTime.now().toIso8601String(),
    );
  }

  factory NotificationIntent.dailyCheckin({
    required String intentId,
    required DateTime scheduledAt,
    required int sourceNotificationId,
  }) {
    return NotificationIntent(
      v: currentVersion,
      type: NotificationIntentType.dailyCheckinReminder,
      intentId: intentId,
      dateIso: scheduledAt.toIso8601String(),
      scheduledAtIso: scheduledAt.toIso8601String(),
      sourceNotificationId: '$sourceNotificationId',
      sentAtIso: DateTime.now().toIso8601String(),
    );
  }

  factory NotificationIntent.requiredUpdate({
    required String intentId,
    required int sourceNotificationId,
  }) {
    return NotificationIntent(
      v: currentVersion,
      type: NotificationIntentType.requiredUpdate,
      intentId: intentId,
      sourceNotificationId: '$sourceNotificationId',
      sentAtIso: DateTime.now().toIso8601String(),
    );
  }

  factory NotificationIntent.badgeUnlocked({
    required String intentId,
    required int sourceNotificationId,
  }) {
    return NotificationIntent(
      v: currentVersion,
      type: NotificationIntentType.badgeUnlocked,
      intentId: intentId,
      sourceNotificationId: '$sourceNotificationId',
      sentAtIso: DateTime.now().toIso8601String(),
    );
  }

  factory NotificationIntent.fallback(String rawPayload) {
    return NotificationIntent(
      v: currentVersion,
      type: NotificationIntentType.genericFallback,
      intentId: 'fallback_${DateTime.now().microsecondsSinceEpoch}',
      sentAtIso: DateTime.now().toIso8601String(),
      sourceNotificationId: rawPayload,
    );
  }
  const NotificationIntent._();

  factory NotificationIntent.fromJson(Map<String, dynamic> json) =>
      _$NotificationIntentFromJson(json);

  static const int currentVersion = 1;
  static const String snoozeSeparator = '__snooze__';

  String get rootIntentId {
    final separatorIndex = intentId.indexOf(snoozeSeparator);
    if (separatorIndex < 0) {
      return intentId;
    }
    return intentId.substring(0, separatorIndex);
  }

  String toPayload() => jsonEncode(toJson());
}
