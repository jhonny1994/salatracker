import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'daily_reminder_config.freezed.dart';
part 'daily_reminder_config.g.dart';

@freezed
@HiveType(typeId: 6)
abstract class DailyReminderConfig with _$DailyReminderConfig {
  const factory DailyReminderConfig({
    @HiveField(0) required int id,
    @HiveField(1) required TimeOfDay time,
    @HiveField(2) required bool enabled,
  }) = _DailyReminderConfig;
  const DailyReminderConfig._();

  static const defaultReminderId = 0;
  static const defaultReminder = DailyReminderConfig(
    id: defaultReminderId,
    time: TimeOfDay(hour: 22, minute: 30),
    enabled: true,
  );

  int get totalMinutes => (time.hour * 60) + time.minute;
}
