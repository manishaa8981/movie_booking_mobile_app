import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/repository/show_repository.dart';
import 'package:movie_ticket_booking/features/show/domain/usecase/get_all_show.dart';

class MockShowRepository extends Mock implements IShowRepository {}

void main() {
  late MockShowRepository repository;
  late GetAllShowUseCase useCase;

  setUp(() {
    repository = MockShowRepository();
    useCase = GetAllShowUseCase(repository: repository);
  });

  final tShow1 = ShowEntity(
    showId: '1',
    start_time: '2023-02-06 10:00',
    end_time: '2023-02-06 12:00',
    date: '(2023, 2, 6)',
    movie: MovieEntity(
        movieId: '1', movie_name: 'Test Movie', trailer_url: 'testurl.com'),
    hall: HallEntity(
        hallId: '1',
        hall_name: 'Test Hall',
        price: 15,
        capacity: 100,
        shows: [],
        seats: []),
  );

  final tShow2 = ShowEntity(
    showId: '2',
    start_time: '2023-02-06 14:00',
    end_time: '2023-02-06 16:00',
    date: '(2023, 2, 6)',
    movie: MovieEntity(
        movieId: '2', movie_name: 'Test Movie 2', trailer_url: 'testurl2.com'),
    hall: HallEntity(
        hallId: '2',
        hall_name: 'Test Hall 2',
        price: 20,
        capacity: 120,
        shows: [],
        seats: []),
  );

  final tShows = [tShow1, tShow2];

  test('should call the [ShowRepo.getAllShows] and return list of shows',
      () async {
    // Arrange
    when(() => repository.getAllShows()).thenAnswer((_) async => Right(tShows));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(tShows));

    // Verify
    verify(() => repository.getAllShows()).called(1);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Failed to load show');
    when(() => repository.getAllShows()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Left(failure));

    // Verify
    verify(() => repository.getAllShows()).called(1);
  });
}
