import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/usecase/get_all_show.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

class MockGetAllShowUseCase extends Mock implements GetAllShowUseCase {}

void main() {
  late MockGetAllShowUseCase getAllShowUseCase;
  late ShowBloc showBloc;

  setUp(() {
    getAllShowUseCase = MockGetAllShowUseCase();
    showBloc = ShowBloc(getAllShowUseCase: getAllShowUseCase);
  });

  group('ShowBloc Tests', () {
final mockHall = HallEntity(
  hallId: 'hall1',
  hall_name: 'Grand Hall',
  capacity: 200, price: 200, shows: [], seats: [],
);

final mockMovie = MovieEntity(
  movieId: 'movie1',
  title: 'Inception',
  duration: '140 minutes', movie_name: 'Titanic', trailer_url: 'http://youtube.com',
);


    final show1 = ShowEntity(
      showId: '1',
      start_time: '8am',
      end_time: '11am',
      date: '2025-02-06',
      hall: mockHall,
      movie: mockMovie,
    );

    final show2 = ShowEntity(
      showId: '2',
      start_time: '10am',
      end_time: '1pm',
      date: '2025-02-06',
      hall:mockHall,
      movie: mockMovie,
    );

    final showsList = [show1, show2];

    blocTest<ShowBloc, ShowState>(
      'emits [loading, loaded] when LoadShows is successful',
      build: () {
        when(() => getAllShowUseCase.call())
            .thenAnswer((_) async => Right(showsList));
        return showBloc;
      },
      act: (bloc) => bloc.add(LoadShows()),
      expect: () => [
        ShowState.initial().copyWith(isLoading: true),
        ShowState.initial().copyWith(isLoading: false, shows: showsList),
      ],
      verify: (_) {
        verify(() => getAllShowUseCase.call()).called(1);
      },
    );

    blocTest<ShowBloc, ShowState>(
      'emits [loading, error] when LoadShows fails',
      build: () {
        when(() => getAllShowUseCase.call()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error loading shows')));
        return showBloc;
      },
      act: (bloc) => bloc.add(LoadShows()),
      expect: () => [
        ShowState.initial().copyWith(isLoading: true),
        ShowState.initial()
            .copyWith(isLoading: false, error: 'Error loading shows'),
      ],
      verify: (_) {
        verify(() => getAllShowUseCase.call()).called(1);
      },
    );
  });
}
