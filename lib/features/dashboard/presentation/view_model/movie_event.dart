part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends MovieEvent {}

class LoadMovieDetails extends MovieEvent {
  final String movieId;

  const LoadMovieDetails({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class SelectMovie extends MovieEvent {
  final MovieEntity movie;

  const SelectMovie({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class SearchMovies extends MovieEvent {
  final String query;

  const SearchMovies(this.query);

  @override
  List<Object> get props => [query];
}