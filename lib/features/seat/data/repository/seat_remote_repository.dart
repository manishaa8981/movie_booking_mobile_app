import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/seat/data/data_source/remote_datasource/remote_datasource.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/repository/seat_repository.dart';

class SeatRemoteRepository implements ISeatRepository {
  final SeatRemoteDatasource _remoteDatasource;
  SeatRemoteRepository(this._remoteDatasource);

  @override
  
  Future<Either<Failure, List<SeatEntity>>> getAllSeats(String hallId) async {
    try {
      final seats = await _remoteDatasource.getAllSeats(hallId);
      return Right(seats);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
