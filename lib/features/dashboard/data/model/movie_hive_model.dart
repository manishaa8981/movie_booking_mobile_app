import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:uuid/uuid.dart';

part 'movie_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.movieTableId)
class MovieHiveModel extends Equatable {
  @HiveField(0)
  final String? movieId;
  @HiveField(1)
  final String movie_name;
  @HiveField(2)
  final String? movie_image;
  @HiveField(3)
  final String? genre;
  @HiveField(4)
  final String? language;
  @HiveField(5)
  final String? duration;
  @HiveField(6)
  final String? description;
  @HiveField(7)
  final String? release_date;
  @HiveField(8)
  final String? cast_name;
  @HiveField(9)
  final String? cast_image;
  @HiveField(10)
  final String? rating;
  @HiveField(11)
  final String? status;
  @HiveField(12)
  final String trailer_url;

  MovieHiveModel({
    String? movieId,
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
  }) : movieId = movieId ?? const Uuid().v4();

  /// ✅ Convert API JSON to Hive Model
  factory MovieHiveModel.fromJson(Map<String, dynamic> json) {
    return MovieHiveModel(
      movieId: json['_id'] ?? '',
      movie_name: json['movie_name'] ?? '',
      movie_image: json['movie_image'],
      genre: json['genre'],
      language: json['language'],
      duration: json['duration'],
      description: json['description'],
      release_date: json['release_date'],
      cast_name: json['cast_name'],
      cast_image: json['cast_image'],
      rating: json['rating'],
      status: json['status'],
      trailer_url: json['trailer_url'] ?? '',
    );
  }

  /// ✅ Convert Hive Model to API JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': movieId,
      'movie_name': movie_name,
      'movie_image': movie_image,
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

  /// ✅ Convert Hive Model to Domain Entity
  MovieEntity toEntity() {
    return MovieEntity(
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
  }

  /// ✅ Convert Domain Entity to Hive Model
  static MovieHiveModel fromEntity(MovieEntity entity) {
    return MovieHiveModel(
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
  }

  /// ✅ Convert List of Hive Models to List of Entities
  static List<MovieEntity> toEntityList(List<MovieHiveModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  /// ✅ Convert List of Entities to List of Hive Models
  static List<MovieHiveModel> fromEntityList(List<MovieEntity> entityList) {
    return entityList.map((entity) => fromEntity(entity)).toList();
  }

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
