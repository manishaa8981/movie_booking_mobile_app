import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/booking/domain/repository/booking_repository.dart';


class GetBookingsUseCase implements UsecaseWithoutParams<List<BookingEntity>> {
  final IBookingRepository repository;

  GetBookingsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<BookingEntity>>> call() {
    return repository.getBookings();
  }
}
