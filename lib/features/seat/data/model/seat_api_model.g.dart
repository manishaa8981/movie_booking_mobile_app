// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatApiModel _$SeatApiModelFromJson(Map<String, dynamic> json) => SeatApiModel(
      seatId: json['_id'] as String?,
      hall: HallApiModel.fromJson(json['hall'] as Map<String, dynamic>),
      show: ShowApiModel.fromJson(json['show'] as Map<String, dynamic>),
      seatColumn: (json['seatColumn'] as num).toInt(),
      seatRow: (json['seatRow'] as num).toInt(),
      seatName: json['seatName'] as String,
      seatStatus: json['seatStatus'] as bool,
    );

Map<String, dynamic> _$SeatApiModelToJson(SeatApiModel instance) =>
    <String, dynamic>{
      '_id': instance.seatId,
      'hall': instance.hall,
      'show': instance.show,
      'seatColumn': instance.seatColumn,
      'seatRow': instance.seatRow,
      'seatName': instance.seatName,
      'seatStatus': instance.seatStatus,
    };
