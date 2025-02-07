import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

class HallEntity extends Equatable {
  final String? hallId;
  final String hall_name;
  final int price;
  final int capacity;
  final List<ShowEntity> shows;
  final List<SeatEntity> seats;

  const HallEntity({
    this.hallId,
    required this.hall_name,
    required this.price,
    required this.capacity,
    required this.shows,
    required this.seats,
  });

  const HallEntity.empty()
      : hallId = '_empty.hallId',
        hall_name = '_empty.hall_name',
        price = 0, // Defaulting to 0 as it's an int
        capacity = 0, // Defaulting to 0 as it's an int
        shows = const [], // Empty list of ShowEntity
        seats = const []; // Empty list of SeatEntity

  @override
  List<Object?> get props => [hallId, hall_name, price, capacity, shows, seats];
}


