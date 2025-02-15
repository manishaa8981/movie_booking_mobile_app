import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_all_movies_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_movie_details_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';

class MockGetAllMoviesUseCase extends Mock implements GetAllMoviesUseCase {}

class MockGetMovieDetailsUseCase extends Mock implements GetMovieDetailsUseCase {}

void main() {
  late MockGetAllMoviesUseCase mockGetAllMoviesUseCase;
  late MockGetMovieDetailsUseCase mockGetMovieDetailsUseCase;
  late MovieBloc movieBloc;

  setUp(() {
    mockGetAllMoviesUseCase = MockGetAllMoviesUseCase();
    mockGetMovieDetailsUseCase = MockGetMovieDetailsUseCase();
    movieBloc = MovieBloc(
      getAllMoviesUseCase: mockGetAllMoviesUseCase,
      getMovieDetailsUseCase: mockGetMovieDetailsUseCase,
    );
  });

  tearDown(() {
    movieBloc.close();
  });

  group('MovieBloc Tests', () {
    final mockMovies = [
      MovieEntity(
        movieId: 'movie1',
        duration: '140 minutes',
        movie_name: 'Inception',
        trailer_url: 'http://youtube.com',
      ),
      MovieEntity(
        movieId: 'movie2',
        duration: '180 minutes',
        movie_name: 'Titanic',
        trailer_url: 'http://youtube.com',
      ),
    ];

    final mockMovieDetails = MovieEntity(
      movieId: 'movie1',
      duration: '140 minutes',
      movie_name: 'Inception',
      trailer_url: 'http://youtube.com',
    );

    test('initial state should be MovieState.initial()', () {
      expect(movieBloc.state, MovieState.initial());
    });

    blocTest<MovieBloc, MovieState>(
      'emits [loading, success] when LoadMovies is successful',
      build: () {
        when(() => mockGetAllMoviesUseCase.call())
            .thenAnswer((_) async => Right(mockMovies));
        return movieBloc;
      },
      act: (bloc) => bloc.add(LoadMovies()),
      expect: () => [
        MovieState.initial().copyWith(isLoading: true),
        MovieState.initial().copyWith(isLoading: false, error: null),
      ],
      verify: (_) {
        verify(() => mockGetAllMoviesUseCase.call()).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [loading, failure] when LoadMovies fails',
      build: () {
        when(() => mockGetAllMoviesUseCase.call()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error loading movies')));
        return movieBloc;
      },
      act: (bloc) => bloc.add(LoadMovies()),
      expect: () => [
        MovieState.initial().copyWith(isLoading: true),
        MovieState.initial().copyWith(isLoading: false, error: 'Error loading movies'),
      ],
      verify: (_) {
        verify(() => mockGetAllMoviesUseCase.call()).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [loading, success] when LoadMovieDetails is successful',
      build: () {
        when(() => mockGetMovieDetailsUseCase.call('movie1'))
            .thenAnswer((_) async => Right(mockMovieDetails));
        return movieBloc;
      },
      act: (bloc) => bloc.add(LoadMovieDetails(movieId: 'movie1')),
      expect: () => [
        MovieState.initial().copyWith(isLoading: true),
        MovieState.initial().copyWith(isLoading: false, error: null),
      ],
      verify: (_) {
        verify(() => mockGetMovieDetailsUseCase.call('movie1')).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [loading, failure] when LoadMovieDetails fails',
      build: () {
        when(() => mockGetMovieDetailsUseCase.call('movie1')).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Error loading movie details')));
        return movieBloc;
      },
      act: (bloc) => bloc.add(LoadMovieDetails(movieId: 'movie1')),
      expect: () => [
        MovieState.initial().copyWith(isLoading: true),
        MovieState.initial().copyWith(isLoading: false, error: 'Error loading movie details'),
      ],
      verify: (_) {
        verify(() => mockGetMovieDetailsUseCase.call('movie1')).called(1);
      },
    );
  });
}
