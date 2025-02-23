// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatApiModel _$SeatApiModelFromJson(Map<String, dynamic> json) => SeatApiModel(
      seatId: json['_id'] as String?,
      hallId: HallApiModel.fromJson(json['hallId'] as Map<String, dynamic>),
      showtimeId: ShowApiModel.fromJson(json['showtimeId'] as Map<String, dynamic>),
      seatColumn: (json['seatColumn'] as num).toInt(),
      seatRow: (json['seatRow'] as num).toInt(),
      seatName: json['seatName'] as String,
      seatStatus: json['seatStatus'] as bool,
    );

Map<String, dynamic> _$SeatApiModelToJson(SeatApiModel instance) =>
    <String, dynamic>{
      '_id': instance.seatId,
      'hallId': instance.hallId,
      'showtimeId': instance.showtimeId,
      'seatColumn': instance.seatColumn,
      'seatRow': instance.seatRow,
      'seatName': instance.seatName,
      'seatStatus': instance.seatStatus,
    };
