// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HallHiveModelAdapter extends TypeAdapter<HallHiveModel> {
  @override
  final int typeId = 2;

  @override
  HallHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HallHiveModel(
      hallId: fields[0] as String,
      hall_name: fields[1] as String,
      price: fields[2] as int,
      capacity: fields[3] as int,
      shows: (fields[4] as List).cast<ShowHiveModel>(),
      seats: (fields[5] as List).cast<SeatHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HallHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hallId)
      ..writeByte(1)
      ..write(obj.hall_name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.capacity)
      ..writeByte(4)
      ..write(obj.shows)
      ..writeByte(5)
      ..write(obj.seats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HallHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
