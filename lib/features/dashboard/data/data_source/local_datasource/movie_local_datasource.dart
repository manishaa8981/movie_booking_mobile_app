import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_hive_model.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

class MovieLocalDatasource{
  final HiveService _hiveService;

  MovieLocalDatasource({required HiveService hiveService}) 
    : _hiveService = hiveService;

  Future<List<MovieEntity>> getAllMovies() async {
    final hiveMovies = await _hiveService.getAllMovies();
    return hiveMovies.map((hiveMovie) => MovieEntity(
      movieId: hiveMovie.movieId,
      movie_name: hiveMovie.movie_name,
      movie_image: hiveMovie.movie_image,
      genre: hiveMovie.genre,
      language: hiveMovie.language,
      duration: hiveMovie.duration,
      description: hiveMovie.description,
      release_date: hiveMovie.release_date,
      cast_name: hiveMovie.cast_name,
      cast_image: hiveMovie.cast_image,
      rating: hiveMovie.rating,
      status: hiveMovie.status,
      trailer_url: hiveMovie.trailer_url,
    )).toList();
  }

  Future<MovieEntity> getMovieDetails(String movieId) async {
    final hiveMovie = await _hiveService.getMovieById(movieId);
    
    if (hiveMovie == null) {
      throw Exception('Movie not found in local storage');
    }
    
    return MovieEntity(
      movieId: hiveMovie.movieId,
      movie_name: hiveMovie.movie_name,
      movie_image: hiveMovie.movie_image,
      genre: hiveMovie.genre,
      language: hiveMovie.language,
      duration: hiveMovie.duration,
      description: hiveMovie.description,
      release_date: hiveMovie.release_date,
      cast_name: hiveMovie.cast_name,
      cast_image: hiveMovie.cast_image,
      rating: hiveMovie.rating,
      status: hiveMovie.status,
      trailer_url: hiveMovie.trailer_url,
    );
  }
}