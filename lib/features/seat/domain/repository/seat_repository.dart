import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';

abstract interface class ISeatRepository {
  Future<Either<Failure, List<SeatEntity>>> getAllSeats(String hallId);

}
