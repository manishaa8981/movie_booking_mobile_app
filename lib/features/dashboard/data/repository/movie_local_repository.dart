import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/local_datasource/movie_local_datasource.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class MovieLocalRepository implements IMovieRepository {
  final MovieLocalDatasource _movieLocalDatasource;

  MovieLocalRepository({required MovieLocalDatasource movieLocalDatasource})
      : _movieLocalDatasource = movieLocalDatasource;

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllMovies() async {
    try {
      final movies = await _movieLocalDatasource.getAllMovies();
      return Right(movies);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error fetching movies: $e'));
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieId) async {
    try {
      final movie = await _movieLocalDatasource.getMovieDetails(movieId);
      return Right(movie);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Error fetching movie details: $e'));
    }
  }
}
