part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<MovieEntity> movies;
  final List<MovieEntity> filteredMovies;

  final bool isLoading;
  final String? error;
  final MovieEntity? selectedMovie;

  const MovieState({
    required this.movies,
    required this.isLoading,
    required this.filteredMovies,
    this.error,
    this.selectedMovie,
  });

  factory MovieState.initial() {
    return const MovieState(
      movies: [],
      filteredMovies: [],
      isLoading: false,
      error: null,
      selectedMovie: null,
    );
  }

  MovieState copyWith({
    List<MovieEntity>? movies,
    List<MovieEntity>? filteredMovies,
    bool? isLoading,
    String? error,
    MovieEntity? selectedMovie,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      filteredMovies: filteredMovies ?? this.filteredMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedMovie: selectedMovie ?? this.selectedMovie,
    );
  }

  @override
  List<Object?> get props => [movies, filteredMovies, isLoading, error];
}
