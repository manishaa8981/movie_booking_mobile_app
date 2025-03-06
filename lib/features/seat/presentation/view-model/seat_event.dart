part of 'seat_bloc.dart';

sealed class SeatEvent extends Equatable {
  const SeatEvent();

  @override
  List<Object?> get props => [];
}

class LoadSeats extends SeatEvent {
  final String hallId;

  const LoadSeats({required this.hallId});

  @override
  List<Object?> get props => [hallId];
}
