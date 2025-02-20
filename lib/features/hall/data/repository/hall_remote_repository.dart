import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/data/data_source/remote_datasource/remote_datasource%20copy.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/repository/hall_repository.dart';

class HallRemoteRepository implements IHallRepository {
  final HallRemoteDatasource _remoteDatasource;
  HallRemoteRepository(this._remoteDatasource);

  @override
  Future<Either<Failure, List<HallEntity>>> getAllHalls() async {
    try {
      final halls = await _remoteDatasource.getAllHalls();
      return Right(halls);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
