import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/repository/hall_repository.dart';
import 'package:movie_ticket_booking/features/hall/domain/usecase/get_all_hall_usecase.dart';

class MockHallRepository extends Mock implements IHallRepository {}

void main() {
  late MockHallRepository repository;
  late GetAllHallUsecase useCase;

  setUp(() {
    repository = MockHallRepository();
    useCase = GetAllHallUsecase(repository: repository);
  });

  final tHall1 = HallEntity(
    hallId: '1',
    hall_name: 'Hall 1',
    price: 100,
    capacity: 50,
    shows: [],
    seats: [],
  );
  final tHall2 = HallEntity(
    hallId: '2',
    hall_name: 'Hall 2',
    price: 150,
    capacity: 100,
    shows: [],
    seats: [],
  );

  final tHalls = [tHall1, tHall2];

  test('should call the [HallRepo.getAllHalls] and return hall list', () async {
    // Arrange
    when(() => repository.getAllHalls()).thenAnswer((_) async => Right(tHalls));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Right(tHalls));

    // Verify
    verify(() => repository.getAllHalls()).called(1);
  });

  test('should return failure when repository fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Failed to load halls');
    when(() => repository.getAllHalls()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase();

    // Assert
    expect(result, Left(failure));

    // Verify
    verify(() => repository.getAllHalls()).called(1);
  });
}
