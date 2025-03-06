import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/remote_datasource/movie_remote_datasource.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class MovieRemoteRepository implements IMovieRepository {
  final MovieRemoteDatasource _remoteDatasource;
  MovieRemoteRepository(this._remoteDatasource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllMovies() async {
    try {
      final movies = await _remoteDatasource.getAllMovies();
      return Right(movies);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieId) async {
    try {
      final movie = await _remoteDatasource.getMovieDetails(movieId);
      return Right(movie);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
