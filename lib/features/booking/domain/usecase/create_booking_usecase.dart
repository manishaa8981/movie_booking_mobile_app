import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/booking/domain/repository/booking_repository.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class CreateBookingParams extends Equatable {
  final String customerId;
  final List<SeatEntity> seats;
  final ShowEntity showtimeId;
  final String paymentStatus;
  final int totalPrice;

  const CreateBookingParams(
      {required this.customerId,
      required this.seats,
      required this.showtimeId,
      required this.paymentStatus,
      required this.totalPrice});

  /// **Empty Constructor**
  const CreateBookingParams.empty()
      : customerId = '',
        seats = const [],
        showtimeId = const ShowEntity.empty(),
        paymentStatus = 'Paid',
        totalPrice = 0;

  @override
  List<Object?> get props => [
        customerId,
      ];
}

class CreateBookingUseCase
    implements UsecaseWithParams<void, CreateBookingParams> {
  final IBookingRepository repository;

  CreateBookingUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CreateBookingParams params) async {
    return await repository.createBooking(
      BookingEntity(
        customerId: params.customerId,
        seats: params.seats,
        showtimeId: params.showtimeId,
        paymentStatus: params.paymentStatus,
        totalPrice: params.totalPrice,
      ),
    );
  }
}
