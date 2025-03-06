import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_api_model.dart';
import 'package:movie_ticket_booking/features/show/data/model/show_api_model.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String customerId;
  final List<SeatApiModel> seats;
  final ShowApiModel showtimeId;
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @JsonKey(name: 'total_price')
  final int totalPrice;

  const BookingApiModel({
    this.id,
    required this.customerId,
    required this.seats,
    required this.showtimeId,
    required this.paymentStatus,
    required this.totalPrice,
  });

  /// Empty Constructor with default values
  BookingApiModel.empty()
      : id = null,
        customerId = '',
        seats = [],
        showtimeId = ShowApiModel.empty(),
        paymentStatus = "Paid",
        totalPrice = 0;

  /// From JSON
  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  /// ✅ Fix: Ensure correct JSON serialization
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  /// Convert API Model to Entity
  BookingEntity toEntity() => BookingEntity(
        id: id,
        customerId: customerId,
        seats: seats.map((seat) => seat.toEntity()).toList(),
        showtimeId: showtimeId.toEntity(),
        paymentStatus: paymentStatus,
        totalPrice: totalPrice,
      );

  /// Convert Entity to API Model
  factory BookingApiModel.fromEntity(BookingEntity booking) {
    return BookingApiModel(
      id: booking.id,
      customerId: booking.customerId,
      seats:
          booking.seats.map((seat) => SeatApiModel.fromEntity(seat)).toList(),
      paymentStatus: booking.paymentStatus,
      totalPrice: booking.totalPrice,
      showtimeId: ShowApiModel.fromEntity(booking.showtimeId),
    );
  }

  static List<BookingEntity> toEntityList(List<BookingApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props =>
      [id, customerId, paymentStatus, totalPrice, seats, showtimeId];
}
