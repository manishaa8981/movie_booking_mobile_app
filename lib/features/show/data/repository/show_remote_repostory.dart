import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/show/data/data_source/remote_datasourse/show_remote_datasource.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/repository/show_repository.dart';

class ShowRemoteRepository implements IShowRepository {
  final ShowRemoteDatasource _remoteDatasource;
  ShowRemoteRepository(this._remoteDatasource);

  @override
  Future<Either<Failure, List<ShowEntity>>> getAllShows() async {
    try {
      final shows = await _remoteDatasource.getAllShows();
      return Right(shows);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
