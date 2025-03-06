import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingRepository {
    Future<Either<Failure, List<BookingEntity>>> getBookings();
  Future<Either<Failure, void>> createBooking(BookingEntity booking);
}