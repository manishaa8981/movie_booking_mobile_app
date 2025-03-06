import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';

abstract interface class ISeatDataSource {
  Future<List<SeatEntity>> getAllSeats(String hallId);
}
