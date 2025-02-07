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
