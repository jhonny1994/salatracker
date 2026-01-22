import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

/// Hive adapter for [TimeOfDay].
///
/// Persists hours and minutes as simple integers.
class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final int typeId = 200; // Reserved range for core adapters

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readByte();
    final minute = reader.readByte();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer
      ..writeByte(obj.hour)
      ..writeByte(obj.minute);
  }
}
