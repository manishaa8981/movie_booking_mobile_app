import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class GetMovieDetailsUseCase {
  final IMovieRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<Either<Failure, MovieEntity>> call(String movieId) {
    return repository.getMovieDetails(movieId);
  }
}
