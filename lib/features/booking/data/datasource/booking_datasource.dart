import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';

abstract interface class IBookingDataSource {
  Future<List<BookingEntity>> getBookings();
  Future<void> createBooking(BookingEntity booking);
}
