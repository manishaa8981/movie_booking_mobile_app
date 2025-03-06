// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowHiveModelAdapter extends TypeAdapter<ShowHiveModel> {
  @override
  final int typeId = 4;

  @override
  ShowHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowHiveModel(
      showId: fields[0] as String,
      start_time: fields[1] as String,
      end_time: fields[2] as String,
      date: fields[3] as String,
      movie: fields[4] as MovieHiveModel,
      hall: fields[5] as HallHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, ShowHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.showId)
      ..writeByte(1)
      ..write(obj.start_time)
      ..writeByte(2)
      ..write(obj.end_time)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.movie)
      ..writeByte(5)
      ..write(obj.hall);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
