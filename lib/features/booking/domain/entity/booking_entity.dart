import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String customerId;
  final List<SeatEntity> seats;
  final ShowEntity showtimeId;
  final String paymentStatus;
  final int totalPrice;

  const BookingEntity({
     this.id,
    required this.customerId,
    required this.seats,
    required this.showtimeId,
    required this.paymentStatus,
    required this.totalPrice,
  });

  /// Empty Constructor (Default Values)
  factory BookingEntity.empty() {
    return BookingEntity(
      id: '',
      customerId: '',
      seats: const [],
      showtimeId: ShowEntity.empty(),
      paymentStatus: 'Unpaid',
      totalPrice: 0,
    );
  }

  @override
  List<Object?> get props => [ customerId, seats, showtimeId, paymentStatus, totalPrice];
}
