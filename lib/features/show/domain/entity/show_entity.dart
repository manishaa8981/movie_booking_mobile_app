import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';

class ShowEntity extends Equatable {
  final String? showId;
  final String start_time;
  final String end_time;
  final String date;
  final MovieEntity movie;
  final HallEntity hall;

  const ShowEntity({
    this.showId,
    required this.start_time,
    required this.end_time,
    required this.date,
    required this.hall,
    required this.movie, 
  });

// yo banaunu ko reason pxi testing ma chainxaa empty constructor
  const ShowEntity.empty()
      : showId = '_empty.showId',
        start_time = '_empty.start_time',
        end_time = '_empty.end_time',
        date = '_empty.date',
        movie = const MovieEntity.empty(), // Reference to MovieEntity.empty()
        hall = const HallEntity.empty();

  @override
  List<Object?> get props => [showId, start_time, end_time, movie, hall];

  static fromJson(Map<String, dynamic> json) {}
}
