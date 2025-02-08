import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_all_movies_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  late MockMovieRepository repository;
  late GetAllMoviesUseCase useCase;

  setUp(() {
    repository = MockMovieRepository();
    useCase = GetAllMoviesUseCase(repository: repository);
  });

  final tMovie1 = MovieEntity(
    movieId: '1',
    movie_name: 'Test Movie 1',
    trailer_url: 'https://testmovie1.com',
  );
  final tMovie2 = MovieEntity(
    movieId: '2',
    movie_name: 'Test Movie 2',
    trailer_url: 'https://testmovie2.com',
  );

  final tMovies = [tMovie1, tMovie2];

  test('should call the [MovieRepo.getAllMovies] and return movie list', () async {
    // Arrange
    when(() => repository.getAllMovies()).thenAnswer((_) async => Right(tMovies));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(tMovies));

    // Verify
    verify(() => repository.getAllMovies()).called(1);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Failed to load data');
    when(() => repository.getAllMovies()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Left(failure));

    // Verify
    verify(() => repository.getAllMovies()).called(1);
  });
}
