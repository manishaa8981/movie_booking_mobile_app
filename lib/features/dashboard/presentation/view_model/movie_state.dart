part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<MovieEntity> movies;
  final bool isLoading;
  final String? error;
  final MovieEntity? selectedMovie;

  const MovieState({
    required this.movies,
    required this.isLoading,
    this.error,
    this.selectedMovie,
  });

  factory MovieState.initial() {
    return const MovieState(
      movies: [],
      isLoading: false,
      error: null,
      selectedMovie: null,
    );
  }

  MovieState copyWith({
    List<MovieEntity>? movies,
    bool? isLoading,
    String? error,
    MovieEntity? selectedMovie,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedMovie: selectedMovie ?? this.selectedMovie,
    );
  }

  @override
  List<Object?> get props => [movies, isLoading, error];
}
