import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/repository/seat_repository.dart';
import 'package:movie_ticket_booking/features/seat/domain/usecase/get_all_seat_usecase.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

// Mock the SeatRepository
class MockSeatRepository extends Mock implements ISeatRepository {}

void main() {
  late MockSeatRepository mockSeatRepository;
  late GetAllSeatUsecase getAllSeatUsecase;

  setUp(() {
    mockSeatRepository = MockSeatRepository();
    getAllSeatUsecase = GetAllSeatUsecase(repository: mockSeatRepository, hallId: '');
  });

  final tSeat1 = SeatEntity(
    seatId: '1',
    hall: const HallEntity.empty(),
    show: const ShowEntity.empty(),
    seatColumn: 1,
    seatRow: 1,
    seatName: 'A1',
    seatStatus: true,
  );
  final tSeat2 = SeatEntity(
    seatId: '2',
    hall: const HallEntity.empty(),
    show: const ShowEntity.empty(),
    seatColumn: 1,
    seatRow: 2,
    seatName: 'A2',
    seatStatus: false,
  );

  final tSeats = [tSeat1, tSeat2];

  test('should return a list of seats when the repository call is successful',
      () async {
    // Arrange
    when(() => mockSeatRepository.getAllSeats())
        .thenAnswer((_) async => Right(tSeats));

    // Act
    final result = await getAllSeatUsecase();

    // Assert
    expect(result, Right(tSeats));

    // Verify that the repository's getAllSeats method was called exactly once
    verify(() => mockSeatRepository.getAllSeats()).called(1);
  });

  test('should return a failure when the repository call is unsuccessful',
      () async {
    // Arrange
    final failure = ApiFailure(message: 'server failure');
    when(() => mockSeatRepository.getAllSeats())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await getAllSeatUsecase();

    // Assert
    expect(result, Left(failure));

    // Verify that the repository's getAllSeats method was called exactly once
    verify(() => mockSeatRepository.getAllSeats()).called(1);
  });
}
