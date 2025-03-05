import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/booking/data/datasource/remote_datasource/booking_remote_datasource.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/booking/domain/repository/booking_repository.dart';

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDatasource _remoteDatasource;

  BookingRemoteRepository(this._remoteDatasource);

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      await _remoteDatasource.createBooking(booking);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: 'Error creating booking: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      final bookings = await _remoteDatasource.getBookings();
      return Right(bookings);
    } catch (e) {
      return Left(ApiFailure(message: 'Error fetching all bookings: $e'));
    }
  }
}
