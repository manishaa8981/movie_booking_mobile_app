// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowApiModel _$ShowApiModelFromJson(Map<String, dynamic> json) => ShowApiModel(
      showId: json['_id'] as String?,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      date: json['date'] as String,
      movieId: MovieApiModel.fromJson(json['movie'] as Map<String, dynamic>),
      hallId: HallApiModel.fromJson(json['hall'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowApiModelToJson(ShowApiModel instance) =>
    <String, dynamic>{
      '_id': instance.showId,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'date': instance.date,
      'movie': instance.movieId,
      'hall': instance.hallId,
    };
