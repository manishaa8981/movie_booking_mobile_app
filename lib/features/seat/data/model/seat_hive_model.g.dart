// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatHiveModelAdapter extends TypeAdapter<SeatHiveModel> {
  @override
  final int typeId = 3;

  @override
  SeatHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatHiveModel(
      seatId: fields[0] as String,
      hallId: fields[1] as HallHiveModel,
      showtimeId: fields[2] as ShowHiveModel,
      seatColumn: fields[3] as int,
      seatRow: fields[4] as int,
      seatName: fields[5] as String,
      seatStatus: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SeatHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.seatId)
      ..writeByte(1)
      ..write(obj.hallId)
      ..writeByte(2)
      ..write(obj.showtimeId)
      ..writeByte(3)
      ..write(obj.seatColumn)
      ..writeByte(4)
      ..write(obj.seatRow)
      ..writeByte(5)
      ..write(obj.seatName)
      ..writeByte(6)
      ..write(obj.seatStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
