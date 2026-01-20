// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerTypeAdapter extends TypeAdapter<PrayerType> {
  @override
  final typeId = 1;

  @override
  PrayerType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PrayerType.fajr;
      case 1:
        return PrayerType.dhuhr;
      case 2:
        return PrayerType.asr;
      case 3:
        return PrayerType.maghrib;
      case 4:
        return PrayerType.isha;
      default:
        return PrayerType.fajr;
    }
  }

  @override
  void write(BinaryWriter writer, PrayerType obj) {
    switch (obj) {
      case PrayerType.fajr:
        writer.writeByte(0);
      case PrayerType.dhuhr:
        writer.writeByte(1);
      case PrayerType.asr:
        writer.writeByte(2);
      case PrayerType.maghrib:
        writer.writeByte(3);
      case PrayerType.isha:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
