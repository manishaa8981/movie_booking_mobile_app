import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/usecase/get_all_seat_usecase.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view-model/seat_bloc.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

/// Mocks for Use Cases and Entities
class MockGetAllSeatUsecase extends Mock implements GetAllSeatUsecase {}

void main() {
  late SeatBloc seatBloc;
  late MockGetAllSeatUsecase mockGetAllSeatUsecase;

  setUp(() {
    mockGetAllSeatUsecase = MockGetAllSeatUsecase();
    seatBloc = SeatBloc(mockGetAllSeatUsecase);

    // Register fallback value for events
    registerFallbackValue(const LoadSeats(hallId: ''));
  });

  tearDown(() {
    seatBloc.close();
  });

  // Sample Hall & Show ID
  const String tHallId = "hall1";
  const String tShowId = "show1";

  // Mock Data
  final mockHall = HallEntity(
    hallId: tHallId,
    hall_name: 'Grand Hall',
    capacity: 200,
    price: 200,
    shows: [],
    seats: [],
  );

  final mockMovie = MovieEntity(
    movieId: 'movie1',
    duration: '140 minutes',
    movie_name: 'Titanic',
    trailer_url: 'http://youtube.com',
  );

  final mockShow = ShowEntity(
    showId: tShowId,
    start_time: '10am',
    end_time: '2pm',
    date: '2025-03-05',
    hall: mockHall,
    movie: mockMovie,
  );

  final mockSeats = [
    SeatEntity(
      seatId: '1',
      hallId: mockHall,
      showtimeId: mockShow,
      seatColumn: 1,
      seatRow: 1,
      seatName: 'A1',
      seatStatus: false,
    ),
    SeatEntity(
      seatId: '2',
      hallId: mockHall,
      showtimeId: mockShow,
      seatColumn: 2,
      seatRow: 1,
      seatName: 'A2',
      seatStatus: true,
    ),
  ];

  group('SeatBloc Tests', () {
    test('initial state should be SeatState.initial()', () {
      expect(seatBloc.state, SeatState.initial());
    });

    blocTest<SeatBloc, SeatState>(
      'emits [isLoading, success] when seats are loaded successfully',
      build: () {
        when(() => mockGetAllSeatUsecase.call(tHallId))
            .thenAnswer((_) async => Right(mockSeats)); // Mock Success Case
        return seatBloc;
      },
      act: (bloc) => bloc.add(const LoadSeats(hallId: tHallId)),
      expect: () => [
        SeatState.initial().copyWith(isLoading: true), // Loading state
        SeatState.initial().copyWith(
          isLoading: false,
          error: null,
          seats: mockSeats, // Success state with loaded seats
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllSeatUsecase.call(tHallId)).called(1);
      },
    );

    blocTest<SeatBloc, SeatState>(
      'emits [isLoading, failure] when seat loading fails',
      build: () {
        when(() => mockGetAllSeatUsecase.call(tHallId)).thenAnswer(
          (_) async => Left(ApiFailure(message: 'Failed to load seats')),
        ); // Mock Failure Case
        return seatBloc;
      },
      act: (bloc) => bloc.add(const LoadSeats(hallId: tHallId)),
      expect: () => [
        SeatState.initial().copyWith(isLoading: true), // Loading state
        SeatState.initial().copyWith(
          isLoading: false,
          error: 'Failed to load seats', // Failure state with error message
          seats: [],
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllSeatUsecase.call(tHallId)).called(1);
      },
    );
  });
}
