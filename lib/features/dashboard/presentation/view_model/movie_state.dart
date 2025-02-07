part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final List<MovieEntity> movies;
  final bool isLoading;
  final String? error;

  const MovieState({
    required this.movies,
    required this.isLoading,
    this.error,
  });

  factory MovieState.initial() {
    return const MovieState(
      movies: [],
      isLoading: false,
      error: null,
    );
  }

  MovieState copyWith({
    List<MovieEntity>? movies,
    bool? isLoading,
    String? error,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [movies, isLoading, error];
}
