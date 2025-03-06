// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_shows_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllShowsDto _$GetAllShowsDtoFromJson(Map<String, dynamic> json) =>
    GetAllShowsDto(
      data: (json['data'] as List<dynamic>)
          .map((e) => ShowApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllShowsDtoToJson(GetAllShowsDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
