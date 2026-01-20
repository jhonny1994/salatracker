// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerEntryAdapter extends TypeAdapter<PrayerEntry> {
  @override
  final typeId = 2;

  @override
  PrayerEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerEntry(
      type: fields[0] as PrayerType,
      scheduledAt: fields[1] as DateTime,
      isCompleted: fields[2] as bool,
      checkedAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.scheduledAt)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.checkedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
