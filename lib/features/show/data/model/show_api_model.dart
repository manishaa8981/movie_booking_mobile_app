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
  final MovieApiModel movie;
  final HallApiModel hall;

  const ShowApiModel({
    this.showId,
    required this.start_time,
    required this.end_time,
    required this.date,
    required this.movie,
    required this.hall,
  });

  /// ✅ Convert API JSON to `ShowApiModel`
  factory ShowApiModel.fromJson(Map<String, dynamic> json) =>
      _$ShowApiModelFromJson(json);

  /// ✅ Convert `ShowApiModel` to JSON
  Map<String, dynamic> toJson() => _$ShowApiModelToJson(this);

  /// ✅ Convert `ShowApiModel` to Domain Entity (`ShowEntity`)
  ShowEntity toEntity() => ShowEntity(
        showId: showId,
        start_time: start_time,
        end_time: end_time,
        date: date,
        movie: movie.toEntity(),
        hall: hall.toEntity(),
      );

  /// ✅ Convert `ShowEntity` to `ShowApiModel`
  static ShowApiModel fromEntity(ShowEntity entity) => ShowApiModel(
        showId: entity.showId,
        start_time: entity.start_time,
        end_time: entity.end_time,
        date: entity.date,
        movie: MovieApiModel.fromEntity(entity.movie),
        hall: HallApiModel.fromEntity(entity.hall),
      );

  /// ✅ Convert List of API Models to List of Entities
  static List<ShowEntity> toEntityList(List<ShowApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ Convert List of Entities to List of API Models
  static List<ShowApiModel> fromEntityList(List<ShowEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  List<Object?> get props => [showId, start_time, end_time, date, movie, hall];
}
