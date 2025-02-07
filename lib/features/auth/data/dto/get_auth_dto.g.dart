// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAuthDTO _$GetAllAuthDTOFromJson(Map<String, dynamic> json) =>
    GetAllAuthDTO(
      succes: json['succes'] as bool,
      token: json['token'] as String,
    );

Map<String, dynamic> _$GetAllAuthDTOToJson(GetAllAuthDTO instance) =>
    <String, dynamic>{
      'succes': instance.succes,
      'token': instance.token,
    };
