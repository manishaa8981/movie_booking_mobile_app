// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bookings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookingsDto _$GetBookingsDtoFromJson(Map<String, dynamic> json) =>
    GetBookingsDto(
      bookings: (json['bookings'] as List<dynamic>)
          .map((e) => BookingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookingsDtoToJson(GetBookingsDto instance) =>
    <String, dynamic>{
      'bookings': instance.bookings,
    };
