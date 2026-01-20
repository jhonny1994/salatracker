// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerDayAdapter extends TypeAdapter<PrayerDay> {
  @override
  final typeId = 3;

  @override
  PrayerDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerDay(
      date: fields[0] as DateTime,
      entries: (fields[1] as List).cast<PrayerEntry>(),
      isComplete: fields[2] as bool,
      points: (fields[3] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, PrayerDay obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.entries)
      ..writeByte(2)
      ..write(obj.isComplete)
      ..writeByte(3)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
