import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_hive_model.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_hive_model.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

part 'show_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.showTableId)
class ShowHiveModel extends Equatable {
  @HiveField(0)
  final String showId;

  @HiveField(1)
  final String start_time;

  @HiveField(2)
  final String end_time;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final MovieHiveModel movie; // ✅ Single Movie, not a List

  @HiveField(5)
  final HallHiveModel hall; // ✅ Single Hall, not a List

  const ShowHiveModel({
    required this.showId,
    required this.start_time,
    required this.end_time,
    required this.date,
    required this.movie,
    required this.hall,
  });

  /// ✅ Convert API JSON to Hive Model
  factory ShowHiveModel.fromJson(Map<String, dynamic> json) {
    return ShowHiveModel(
      showId: json['_id'] ?? '',
      start_time: json['start_time'] ?? '',
      end_time: json['end_time'] ?? '',
      date: json['date'] ?? '',
      movie: MovieHiveModel.fromJson(json['movie']),
      hall: HallHiveModel.fromJson(json['hall']),
    );
  }

  /// ✅ Convert Hive Model to API JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': showId,
      'start_time': start_time,
      'end_time': end_time,
      'date': date,
      'movie': movie.toJson(),
      'hall': hall.toJson(),
    };
  }

  /// ✅ Convert Hive Model to Domain Entity
  ShowEntity toEntity() {
    return ShowEntity(
      showId: showId,
      start_time: start_time,
      end_time: end_time,
      date: date,
      movie: movie.toEntity(),
      hall: hall.toEntity(),
    );
  }

  /// ✅ Convert Domain Entity to Hive Model
  static ShowHiveModel fromEntity(ShowEntity entity) {
    return ShowHiveModel(
      showId: entity.showId ?? '',
      start_time: entity.start_time,
      end_time: entity.end_time,
      date: entity.date,
      movie: MovieHiveModel.fromEntity(entity.movie),
      hall: HallHiveModel.fromEntity(entity.hall),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [showId, start_time, end_time, movie, date, hall];
}
