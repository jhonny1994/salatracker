// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationIntent _$NotificationIntentFromJson(Map<String, dynamic> json) =>
    _NotificationIntent(
      v: (json['v'] as num).toInt(),
      type: $enumDecode(_$NotificationIntentTypeEnumMap, json['type']),
      intentId: json['intentId'] as String,
      prayerType: $enumDecodeNullable(_$PrayerTypeEnumMap, json['prayerType']),
      dateIso: json['dateIso'] as String?,
      scheduledAtIso: json['scheduledAtIso'] as String?,
      sourceNotificationId: json['sourceNotificationId'] as String?,
      sentAtIso: json['sentAtIso'] as String?,
    );

Map<String, dynamic> _$NotificationIntentToJson(_NotificationIntent instance) =>
    <String, dynamic>{
      'v': instance.v,
      'type': _$NotificationIntentTypeEnumMap[instance.type]!,
      'intentId': instance.intentId,
      'prayerType': _$PrayerTypeEnumMap[instance.prayerType],
      'dateIso': instance.dateIso,
      'scheduledAtIso': instance.scheduledAtIso,
      'sourceNotificationId': instance.sourceNotificationId,
      'sentAtIso': instance.sentAtIso,
    };

const _$NotificationIntentTypeEnumMap = {
  NotificationIntentType.prayerReminder: 'prayerReminder',
  NotificationIntentType.dailyCheckinReminder: 'dailyCheckinReminder',
  NotificationIntentType.requiredUpdate: 'requiredUpdate',
  NotificationIntentType.badgeUnlocked: 'badgeUnlocked',
  NotificationIntentType.genericFallback: 'genericFallback',
};

const _$PrayerTypeEnumMap = {
  PrayerType.fajr: 'fajr',
  PrayerType.dhuhr: 'dhuhr',
  PrayerType.asr: 'asr',
  PrayerType.maghrib: 'maghrib',
  PrayerType.isha: 'isha',
};
