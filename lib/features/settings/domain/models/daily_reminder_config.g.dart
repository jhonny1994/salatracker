// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reminder_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyReminderConfigAdapter extends TypeAdapter<DailyReminderConfig> {
  @override
  final typeId = 6;

  @override
  DailyReminderConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyReminderConfig(
      id: (fields[0] as num).toInt(),
      time: fields[1] as TimeOfDay,
      enabled: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DailyReminderConfig obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.enabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyReminderConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
