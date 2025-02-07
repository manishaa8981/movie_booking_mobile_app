import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

abstract interface class IMovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getAllMovies();
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieId);
}
