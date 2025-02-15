// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieHiveModelAdapter extends TypeAdapter<MovieHiveModel> {
  @override
  final int typeId = 1;

  @override
  MovieHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieHiveModel(
      movieId: fields[0] as String?,
      movie_name: fields[1] as String,
      movie_image: fields[2] as String?,
      genre: fields[3] as String?,
      language: fields[4] as String?,
      duration: fields[5] as String?,
      description: fields[6] as String?,
      release_date: fields[7] as String?,
      cast_name: fields[8] as String?,
      cast_image: fields[9] as String?,
      rating: fields[10] as String?,
      status: fields[11] as String?,
      trailer_url: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieHiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.movie_name)
      ..writeByte(2)
      ..write(obj.movie_image)
      ..writeByte(3)
      ..write(obj.genre)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.release_date)
      ..writeByte(8)
      ..write(obj.cast_name)
      ..writeByte(9)
      ..write(obj.cast_image)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.trailer_url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
