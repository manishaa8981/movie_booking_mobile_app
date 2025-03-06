// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      id: json['_id'] as String?,
      customerId: json['customerId'] as String,
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      showtimeId:
          ShowApiModel.fromJson(json['showtimeId'] as Map<String, dynamic>),
      paymentStatus: json['payment_status'] as String,
      totalPrice: (json['total_price'] as num).toInt(),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'customerId': instance.customerId,
      'seats': instance.seats,
      'showtimeId': instance.showtimeId,
      'payment_status': instance.paymentStatus,
      'total_price': instance.totalPrice,
    };
