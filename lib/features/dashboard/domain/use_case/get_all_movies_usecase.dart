import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/app/usecase/usecase.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class GetAllMoviesUseCase implements UsecaseWithoutParams<List<MovieEntity>> {
  final IMovieRepository repository;

  GetAllMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call() {
    return repository.getAllMovies();
  }
}