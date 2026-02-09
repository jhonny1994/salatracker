// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadgeTypeAdapter extends TypeAdapter<BadgeType> {
  @override
  final typeId = 20;

  @override
  BadgeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BadgeType.firstPrayerLogged;
      case 1:
        return BadgeType.weekConsistency;
      case 2:
        return BadgeType.monthComplete;
      case 3:
        return BadgeType.seasonChampion;
      default:
        return BadgeType.firstPrayerLogged;
    }
  }

  @override
  void write(BinaryWriter writer, BadgeType obj) {
    switch (obj) {
      case BadgeType.firstPrayerLogged:
        writer.writeByte(0);
      case BadgeType.weekConsistency:
        writer.writeByte(1);
      case BadgeType.monthComplete:
        writer.writeByte(2);
      case BadgeType.seasonChampion:
        writer.writeByte(3);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
