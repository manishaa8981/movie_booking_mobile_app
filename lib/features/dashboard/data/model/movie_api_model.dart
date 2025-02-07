import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

class MovieApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? movieId;
  final String movie_name;
  final String? movie_image;
  final String? title;
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

  const MovieApiModel({
    this.movieId,
    required this.movie_name,
    this.movie_image,
    this.title,
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

  // Convert JSON to MovieApiModel
  factory MovieApiModel.fromJson(Map<String, dynamic> json) {
    return MovieApiModel(
      movieId: json['_id'] as String?,
      movie_name: json['movie_name'] as String,
      movie_image: json['movie_image'] as String?,
      title: json['title'] as String?,
      genre: json['genre'] as String?,
      language: json['language'] as String?,
      duration: json['duration'] as String?,
      description: json['description'] as String?,
      release_date: json['release_date'] as String?,
      cast_name: json['cast_name'] as String?,
      cast_image: json['cast_image'] as String?,
      rating: json['rating'] as String?,
      status: json['status'] as String?,
      trailer_url: json['trailer_url'] as String,
    );
  }

  // Convert MovieApiModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': movieId,
      'movie_name': movie_name,
      'movie_image': movie_image,
      'title': title,
      'genre': genre,
      'language': language,
      'duration': duration,
      'description': description,
      'release_date': release_date,
      'cast_name': cast_name,
      'cast_image': cast_image,
      'rating': rating,
      'status': status,
      'trailer_url': trailer_url,
    };
  }

  // Convert API Model to Domain Entity
  MovieEntity toEntity() {
    return MovieEntity(
      movieId: movieId,
      movie_name: movie_name,
      movie_image: movie_image,
      title: title,
      genre: genre,
      language: language,
      duration: duration,
      description: description,
      release_date: release_date,
      cast_name: cast_name,
      cast_image: cast_image,
      rating: rating,
      status: status,
      trailer_url: trailer_url,
    );
  }

  // Convert Domain Entity to API Model
  static MovieApiModel fromEntity(MovieEntity entity) {
    return MovieApiModel(
      movieId: entity.movieId,
      movie_name: entity.movie_name,
      movie_image: entity.movie_image,
      title: entity.title,
      genre: entity.genre,
      language: entity.language,
      duration: entity.duration,
      description: entity.description,
      release_date: entity.release_date,
      cast_name: entity.cast_name,
      cast_image: entity.cast_image,
      rating: entity.rating,
      status: entity.status,
      trailer_url: entity.trailer_url,
    );
  }

  // Convert API List to Entity List
  static List<MovieEntity> toEntityList(List<MovieApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Convert Entity List to API Model List
  static List<MovieApiModel> fromEntityList(List<MovieEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }

  @override
  List<Object?> get props => [
        movieId,
        movie_name,
        movie_image,
        title,
        genre,
        language,
        duration,
        description,
        release_date,
        cast_name,
        cast_image,
        rating,
        status,
        trailer_url,
      ];
}
