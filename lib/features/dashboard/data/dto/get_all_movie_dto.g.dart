// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMovieDTO _$GetAllMovieDTOFromJson(Map<String, dynamic> json) =>
    GetAllMovieDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => MovieApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMovieDTOToJson(GetAllMovieDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
