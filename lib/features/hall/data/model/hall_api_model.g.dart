// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HallApiModel _$HallApiModelFromJson(Map<String, dynamic> json) => HallApiModel(
      hallId: json['_id'] as String?,
      hall_name: json['hall_name'] as String,
      price: (json['price'] as num).toInt(),
      capacity: (json['capacity'] as num).toInt(),
      shows: (json['showtimes'] as List<dynamic>)
          .map((e) => ShowApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HallApiModelToJson(HallApiModel instance) =>
    <String, dynamic>{
      '_id': instance.hallId,
      'hall_name': instance.hall_name,
      'price': instance.price,
      'capacity': instance.capacity,
      'showtimes': instance.shows,
      'seats': instance.seats,
    };
