// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final typeId = 4;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      prayerTimes: (fields[0] as Map).cast<PrayerType, TimeOfDay>(),
      offsets: (fields[1] as Map).cast<PrayerType, int>(),
      notificationsEnabled: fields[2] as bool,
      hapticsEnabled: fields[3] as bool,
      pointsVisible: fields[4] as bool,
      themeMode: fields[5] as AppThemeMode,
      localeCode: fields[6] as String?,
      weekStart: (fields[7] as num).toInt(),
      onboardingComplete: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.prayerTimes)
      ..writeByte(1)
      ..write(obj.offsets)
      ..writeByte(2)
      ..write(obj.notificationsEnabled)
      ..writeByte(3)
      ..write(obj.hapticsEnabled)
      ..writeByte(4)
      ..write(obj.pointsVisible)
      ..writeByte(5)
      ..write(obj.themeMode)
      ..writeByte(6)
      ..write(obj.localeCode)
      ..writeByte(7)
      ..write(obj.weekStart)
      ..writeByte(8)
      ..write(obj.onboardingComplete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
