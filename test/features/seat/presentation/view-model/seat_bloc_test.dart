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


class MockGetAllSeatUsecase extends Mock implements GetAllSeatUsecase {}
class MockShowEntity extends Mock implements ShowEntity {}
class MockHallEntity extends Mock implements HallEntity {}



void main() {
  late SeatBloc seatBloc;
  late MockGetAllSeatUsecase mockGetAllSeatUsecase;
  late MockHallEntity mockHallEntity;
  late MockShowEntity mockShowEntity;

  final mockHall = HallEntity(
  hallId: 'hall1',
  hall_name: 'Grand Hall',
  capacity: 200, price: 200, shows: [], seats: [],
);

final mockMovie = MovieEntity(
  movieId: 'movie1',
  duration: '140 minutes', movie_name: 'Titanic', trailer_url: 'http://youtube.com',
);


final mockShow = ShowEntity(start_time: '10am', end_time: '2pm', date: '2025-03-05', hall: mockHall, movie: mockMovie,

);
// Define mock data

  final mockSeats = [
    SeatEntity(
      seatId: '1',
      hall: mockHall,
      show: mockShow,
      seatColumn: 1,
      seatRow: 1,
      seatName: 'A1',
      seatStatus: false,
    ),
    SeatEntity(
      seatId: '2',
      hall: mockHall,
      show: mockShow,
      seatColumn: 2,
      seatRow: 1,
      seatName: 'A2',
      seatStatus: true,
    ),
  ];

  setUp(() {
    // Initialize mocks
    mockGetAllSeatUsecase = MockGetAllSeatUsecase();
    mockHallEntity = MockHallEntity();
    mockShowEntity = MockShowEntity();
    seatBloc = SeatBloc(getAllSeatUsecase: mockGetAllSeatUsecase);

    // Register a fallback value for event
    registerFallbackValue(LoadSeats());
  });

  tearDown(() {
    seatBloc.close();
  });

  group('SeatBloc', () {
    test('initial state should be SeatState.initial()', () {
      expect(seatBloc.state, SeatState.initial());
    });

    blocTest<SeatBloc, SeatState>(
      'emits [isLoading, success] when seats are loaded successfully',
      build: () {
        when(() => mockGetAllSeatUsecase.call())
            .thenAnswer((_) async => Right(mockSeats)); // Success case
        return seatBloc;
      },
      act: (bloc) => bloc.add(LoadSeats()),
      expect: () => [
        SeatState.initial().copyWith(isLoading: true), // Loading state
        SeatState.initial().copyWith(
          isLoading: false,
          error: null,
          seats: mockSeats, // Success state
        ),
      ],
    );

    blocTest<SeatBloc, SeatState>(
      'emits [isLoading, failure] when seat loading fails',
      build: () {
        when(() => mockGetAllSeatUsecase.call())
            .thenAnswer((_) async => Left(ApiFailure(message: 'Failed to load seats'))); // Failure case
        return seatBloc;
      },
      act: (bloc) => bloc.add(LoadSeats()),
      expect: () => [
        SeatState.initial().copyWith(isLoading: true), // Loading state
        SeatState.initial().copyWith(
          isLoading: false,
          error: 'Failed to load seats', // Failure state with error message
          seats: [],
        ),
      ],
    );
  });
}
