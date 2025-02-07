import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_movie_details_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  late MockMovieRepository repository;
  late GetMovieDetailsUseCase useCase;

  setUp(() {
    repository = MockMovieRepository();
    useCase = GetMovieDetailsUseCase(repository);
  });

  final tMovie = MovieEntity(
    movieId: '1',
    movie_name: 'Test Movie 1',
    trailer_url: 'https://testmovie1.com',
  );

  test('should call the [MovieRepo.getMovieDetails] and return movie details', () async {
    // Arrange
    const movieId = '1';
    when(() => repository.getMovieDetails(movieId)).thenAnswer((_) async => Right(tMovie));

    // Act
    final result = await useCase(movieId);

    // Assert
    expect(result, Right(tMovie));

    // Verify
    verify(() => repository.getMovieDetails(movieId)).called(1);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    const movieId = '1';
    final failure = ApiFailure(message: 'Failed to load movie details');
    when(() => repository.getMovieDetails(movieId)).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(movieId);

    // Assert
    expect(result, Left(failure));

    // Verify
    verify(() => repository.getMovieDetails(movieId)).called(1);
  });
}
