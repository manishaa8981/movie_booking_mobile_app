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

  factory MovieApiModel.fromJson(Map<String, dynamic> json) =>
      _$MovieApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieApiModelToJson(this);

//To entity
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
//From entity
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

//To Entity List
  static List<MovieEntity> toEntityList(List<MovieApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

//From entity list
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
