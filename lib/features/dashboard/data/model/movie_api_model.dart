import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

part 'movie_api_model.g.dart';

@JsonSerializable()
class MovieApiModel extends Equatable {
  @JsonKey(name: '_id')
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

  const MovieApiModel({
    this.movieId,
    required this.movie_name,
    this.movie_image,
    this.genre,
    this.language,
    this.duration,
    this.description,
    this.release_date,
    this.cast_name,
    this.cast_image,
    this.rating,
    this.status,
    required this.trailer_url,
  });

  /// Factory method for an empty `MovieApiModel`
  factory MovieApiModel.empty() => const MovieApiModel(
        movieId: "N/A",
        movie_name: "Unknown Movie",
        movie_image: null,
        genre: "Unknown",
        language: "Unknown",
        duration: "Unknown",
        description: "No description available",
        release_date: "Unknown",
        cast_name: "Unknown Cast",
        cast_image: null,
        rating: "N/A",
        status: "Unknown",
        trailer_url: "",
      );

  factory MovieApiModel.fromJson(Map<String, dynamic> json) {
    return MovieApiModel(
      movieId: json['_id'] as String?,
      movie_name: json['movie_name'] as String? ?? "Unknown Movie",
      movie_image: json['movie_image'] as String?,
      genre: json['genre'] as String?,
      language: json['language'] as String?,
      duration: json['duration'] as String?,
      description: json['description'] as String?,
      release_date: json['release_date'] as String?,
      cast_name: json['cast_name'] as String?,
      cast_image: json['cast_image'] as String?,
      rating: json['rating'] as String?,
      status: json['status'] as String?,
      trailer_url: json['trailer_url'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() => _$MovieApiModelToJson(this);

  /// Convert `MovieApiModel` to `MovieEntity`
  MovieEntity toEntity() => MovieEntity(
        movieId: movieId,
        movie_name: movie_name,
        movie_image: movie_image,
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

  /// Convert `MovieEntity` to `MovieApiModel`
  static MovieApiModel fromEntity(MovieEntity entity) => MovieApiModel(
        movieId: entity.movieId,
        movie_name: entity.movie_name,
        movie_image: entity.movie_image,
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

  /// Convert List of API Models to List of Entities
  static List<MovieEntity> toEntityList(List<MovieApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// Convert List of Entities to List of API Models
  static List<MovieApiModel> fromEntityList(List<MovieEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

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
        cast_name,
        cast_image,
        rating,
        status,
        trailer_url,
      ];
}
