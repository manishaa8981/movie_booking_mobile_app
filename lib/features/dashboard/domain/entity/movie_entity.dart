import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String? movieId;
  final String movie_name;
  final String? movie_image;
  final String? genre;
  final String? language;
  final String? duration;
  final String? description;
  final String? release_date;
  final String? cast_name;
  final String? cast_image;
  final String? rating;
  final String? status;
  final String trailer_url;

  const MovieEntity({
    this.movieId,
    required this.movie_name,
    this.movie_image,
    this.genre,
    this.language,
    this.duration,
    this.description,
    this.release_date,
    this.cast_image,
    this.cast_name,
    this.rating,
    this.status,
    required this.trailer_url,
  });

  const MovieEntity.empty()
      : movieId = '_empty.movieId',
        movie_name = '_empty.movie_name',
        movie_image = null,
        genre = '_empty.genre',
        language = '_empty.language',
        duration = '_empty.duration',
        description = '_empty.description',
        release_date = '_empty.release_date',
        cast_image = null,
        cast_name = '_empty.cast_name',
        rating = '_empty.rating',
        status = '_empty.status',
        trailer_url = '_empty.trailer_url';

  @override
  List<Object?> get props => [
        movieId,
        movie_name,
        movie_image,
        genre,
        language,
        duration,
        description,
        release_date,
        cast_image,
        cast_name,
        rating,
        status,
        trailer_url,
      ];
}
