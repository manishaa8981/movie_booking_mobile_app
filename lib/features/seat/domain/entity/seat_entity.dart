import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class SeatEntity extends Equatable {
  final String? seatId;
  final HallEntity hall;
  final ShowEntity show;
  final int? seatColumn;
  final int? seatRow;
  final String? seatName;
  final bool? seatStatus; // Changed from Bool to bool

  const SeatEntity({
    this.seatId,
    required this.hall,
    required this.show,
    this.seatColumn,
    this.seatRow,
    this.seatName,
    this.seatStatus,
  });

  // Empty constructor for testing purposes
  const SeatEntity.empty()
      : seatId = '_empty.seatId',
        hall = const HallEntity.empty(),
        show = const ShowEntity.empty(),
        seatColumn = 0,
        seatRow = 0,
        seatName = '_empty.seatName',
        seatStatus = false;

  @override
  List<Object?> get props => [
        seatId,
        hall,
        show,
        seatColumn,
        seatRow,
        seatName,
        seatStatus,
      ];
}
