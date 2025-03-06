import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class SeatEntity extends Equatable {
  final String? seatId;
  final HallEntity hallId;
  final ShowEntity showtimeId;
  final int? seatColumn;
  final int? seatRow;
  final String? seatName;
  final bool? seatStatus; // Changed from Bool to bool

  const SeatEntity({
    this.seatId,
    required this.hallId,
    required this.showtimeId,
    this.seatColumn,
    this.seatRow,
    this.seatName,
    this.seatStatus,
  });

  // Empty constructor for testing purposes
  const SeatEntity.empty()
      : seatId = '_empty.seatId',
        hallId = const HallEntity.empty(),
        showtimeId = const ShowEntity.empty(),
        seatColumn = 0,
        seatRow = 0,
        seatName = '_empty.seatName',
        seatStatus = false;

  @override
  List<Object?> get props => [
        seatId,
        hallId,
        showtimeId,
        seatColumn,
        seatRow,
        seatName,
        seatStatus,
      ];
}
