import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/usecase/get_all_hall_usecase.dart';
import 'package:movie_ticket_booking/features/hall/presentation/view-model/hall_bloc.dart';

class MockGetAllHallUsecase extends Mock implements GetAllHallUsecase {}

void main() {
  late MockGetAllHallUsecase mockGetAllHallUsecase;
  late HallBloc hallBloc;

  setUp(() {
    mockGetAllHallUsecase = MockGetAllHallUsecase();
    hallBloc = HallBloc(getAllHallUsecase: mockGetAllHallUsecase);
  });

  tearDown(() {
    hallBloc.close();
  });

  group('HallBloc Tests', () {
    final mockHalls = [
      HallEntity(
        hallId: 'hall1',
        hall_name: 'Grand Hall',
        capacity: 200,
        price: 300,
        shows: [],
        seats: [],
      ),
      HallEntity(
        hallId: 'hall2',
        hall_name: 'VIP Lounge',
        capacity: 100,
        price: 500,
        shows: [],
        seats: [],
      ),
    ];

    test('initial state should be HallState.initial()', () {
      expect(hallBloc.state, HallState.initial());
    });

    blocTest<HallBloc, HallState>(
      'emits [loading, success] when LoadHalls is successful',
      build: () {
        when(() => mockGetAllHallUsecase.call())
            .thenAnswer((_) async => Right(mockHalls));
        return hallBloc;
      },
      act: (bloc) => bloc.add(LoadHalls()),
      expect: () => [
        HallState.initial().copyWith(isLoading: true),
        HallState.initial().copyWith(isLoading: false, error: null),
      ],
      verify: (_) {
        verify(() => mockGetAllHallUsecase.call()).called(1);
      },
    );

    blocTest<HallBloc, HallState>(
      'emits [loading, failure] when LoadHalls fails',
      build: () {
        when(() => mockGetAllHallUsecase.call()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error loading halls')));
        return hallBloc;
      },
      act: (bloc) => bloc.add(LoadHalls()),
      expect: () => [
        HallState.initial().copyWith(isLoading: true),
        HallState.initial()
            .copyWith(isLoading: false, error: 'Error loading halls'),
      ],
      verify: (_) {
        verify(() => mockGetAllHallUsecase.call()).called(1);
      },
    );
  });
}
