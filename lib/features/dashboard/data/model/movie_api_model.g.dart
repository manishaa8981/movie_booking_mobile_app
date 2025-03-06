// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieApiModel _$MovieApiModelFromJson(Map<String, dynamic> json) =>
    MovieApiModel(
      movieId: json['_id'] as String?,
      movie_name: json['movie_name'] as String,
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
      trailer_url: json['trailer_url'] as String,
    );

Map<String, dynamic> _$MovieApiModelToJson(MovieApiModel instance) =>
    <String, dynamic>{
      '_id': instance.movieId,
      'movie_name': instance.movie_name,
      'movie_image': instance.movie_image,
      'genre': instance.genre,
      'language': instance.language,
      'duration': instance.duration,
      'description': instance.description,
      'release_date': instance.release_date,
      'cast_name': instance.cast_name,
      'cast_image': instance.cast_image,
      'rating': instance.rating,
      'status': instance.status,
      'trailer_url': instance.trailer_url,
    };
