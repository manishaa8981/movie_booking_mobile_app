import 'package:json_annotation/json_annotation.dart';

import '../model/booking_api_model.dart';

part 'get_bookings_dto.g.dart';

// @JsonSerializable()
// class GetAllBookingDTO {
//   final List<BookingApiModel> bookings;
//   final int count;

//   GetAllBookingDTO({required this.bookings, required this.count});

//   factory GetAllBookingDTO.fromJson(Map<String, dynamic> json) {
//     return GetAllBookingDTO(
//       bookings: (json['bookings'] as List)
//           .map((e) => BookingApiModel.fromJson(e))
//           .toList(),
//       count: json['count'],
//     );
//   }

//   List<Map<String, dynamic>> toJson() =>
//       bookings.map((e) => e.toJson()).toList();
// }
@JsonSerializable(explicitToJson: true)
class GetBookingsDto {
  final List<BookingApiModel> bookings;

  GetBookingsDto({required this.bookings});

  /// ✅ Fix: Directly map a `List<dynamic>` instead of expecting a `{ "bookings": [...] }` object.
  factory GetBookingsDto.fromJson(List<dynamic> jsonList) {
    return GetBookingsDto(
      bookings: jsonList
          .map((e) => BookingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJson() =>
      bookings.map((e) => e.toJson()).toList();
}
