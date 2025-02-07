import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

abstract interface class IMovieDataSource {
  Future<List<MovieEntity>> getAllMovies();
  Future<MovieEntity> getMovieDetails(String movieId);
}
