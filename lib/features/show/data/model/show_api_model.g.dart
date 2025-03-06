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
      movieId: json['movieId'] == null
          ? null
          : MovieApiModel.fromJson(json['movieId'] as Map<String, dynamic>),
      hallId: json['hallId'] == null
          ? null
          : HallApiModel.fromJson(json['hallId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowApiModelToJson(ShowApiModel instance) =>
    <String, dynamic>{
      '_id': instance.showId,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'date': instance.date,
      'movieId': instance.movieId,
      'hallId': instance.hallId,
    };
