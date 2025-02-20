// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:movie_ticket_booking/features/dashboard/data/model/movie_api_model.dart';
// import 'package:movie_ticket_booking/features/hall/data/model/hall_api_model.dart';
// import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

// part 'show_api_model.g.dart';

// @JsonSerializable()
// class ShowApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? showId;
//   final String start_time;
//   final String end_time;
//   final String date;
//   @JsonKey(name: 'movieId')
//   final MovieApiModel movie;
//    @JsonKey(name: 'hallId')
//   final HallApiModel hall;

//   const ShowApiModel({
//     this.showId,
//     required this.start_time,
//     required this.end_time,
//     required this.date,
//     required this.movie,
//     required this.hall,
//   });

//   /// ✅ Convert API JSON to `ShowApiModel`
//   factory ShowApiModel.fromJson(Map<String, dynamic> json) =>
//       _$ShowApiModelFromJson(json);

//   /// ✅ Convert `ShowApiModel` to JSON
//   Map<String, dynamic> toJson() => _$ShowApiModelToJson(this);

//   /// ✅ Convert `ShowApiModel` to Domain Entity (`ShowEntity`)
//   ShowEntity toEntity() => ShowEntity(
//         showId: showId,
//         start_time: start_time,
//         end_time: end_time,
//         date: date,
//         movie: movie.toEntity(),
//         hall: hall.toEntity(),
//       );

//   /// ✅ Convert `ShowEntity` to `ShowApiModel`
//   static ShowApiModel fromEntity(ShowEntity entity) => ShowApiModel(
//         showId: entity.showId,
//         start_time: entity.start_time,
//         end_time: entity.end_time,
//         date: entity.date,
//         movie: MovieApiModel.fromEntity(entity.movie),
//         hall: HallApiModel.fromEntity(entity.hall),
//       );

//   /// ✅ Convert List of API Models to List of Entities
//   static List<ShowEntity> toEntityList(List<ShowApiModel> models) =>
//       models.map((model) => model.toEntity()).toList();

//   /// ✅ Convert List of Entities to List of API Models
//   static List<ShowApiModel> fromEntityList(List<ShowEntity> entities) =>
//       entities.map((entity) => fromEntity(entity)).toList();

//   @override
//   List<Object?> get props => [showId, start_time, end_time, date, movie, hall];
// }
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_api_model.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_api_model.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

part 'show_api_model.g.dart';

@JsonSerializable()
class ShowApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? showId;
  final String start_time;
  final String end_time;
  final String date;
  final MovieApiModel? movieId;
  final HallApiModel? hallId;

  const ShowApiModel({
    this.showId,
    required this.start_time,
    required this.end_time,
    required this.date,
    this.movieId,
    this.hallId,
  });

  /// ✅ Convert API JSON to `ShowApiModel`
 factory ShowApiModel.fromJson(Map<String, dynamic> json) {
  return ShowApiModel(
    showId: json['_id'] as String?,
    start_time: json['start_time'] as String? ?? "Unknown",
    end_time: json['end_time'] as String? ?? "Unknown",
    date: json['date'] as String? ?? "Unknown",

    /// ✅ Fix: Handle both String and Map for `movieId`
    movieId: json['movieId'] is String
        ? MovieApiModel.empty() // If it's a string, return an empty model
        : MovieApiModel.fromJson(json['movieId'] as Map<String, dynamic>),

    /// ✅ Fix: Handle both String and Map for `hallId`
    hallId: json['hallId'] is String
        ? HallApiModel.empty() // If it's a string, return an empty model
        : HallApiModel.fromJson(json['hallId'] as Map<String, dynamic>),
  );
}

 /// ✅ Provide an empty instance
  static ShowApiModel empty() {
    return ShowApiModel(
      showId: '',
      start_time: '',
      end_time: '',
      date: '',
      movieId: MovieApiModel.empty(), // Also needs an empty method
      hallId: HallApiModel.empty(),   // Also needs an empty method
    );
  }

  /// ✅ Convert `ShowApiModel` to JSON
  Map<String, dynamic> toJson() => _$ShowApiModelToJson(this);

  /// ✅ Convert `ShowApiModel` to Domain Entity (`ShowEntity`)
  ShowEntity toEntity() => ShowEntity(
        showId: showId,
        start_time: start_time,
        end_time: end_time,
        date: date,
        movie: movieId?.toEntity() ?? MovieApiModel.empty().toEntity(), // ✅ Handles null
        hall: hallId?.toEntity() ?? HallApiModel.empty().toEntity(), // ✅ Handles null
      );

  /// ✅ Convert `ShowEntity` to `ShowApiModel`
  static ShowApiModel fromEntity(ShowEntity entity) => ShowApiModel(
        showId: entity.showId,
        start_time: entity.start_time,
        end_time: entity.end_time,
        date: entity.date,
        movieId: entity.movie != null ? MovieApiModel.fromEntity(entity.movie) : null,
        hallId: entity.hall != null ? HallApiModel.fromEntity(entity.hall) : null,
      );

  /// ✅ Convert List of API Models to List of Entities
  static List<ShowEntity> toEntityList(List<ShowApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ Convert List of Entities to List of API Models
  static List<ShowApiModel> fromEntityList(List<ShowEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props =>
      [showId, start_time, end_time, date, movieId, hallId];
}
