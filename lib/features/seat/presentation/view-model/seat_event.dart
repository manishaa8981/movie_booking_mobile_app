part of 'seat_bloc.dart';

@immutable
sealed class SeatEvent extends Equatable {
  const SeatEvent();

  @override
  List<Object> get props => [];
}

final class LoadSeats extends SeatEvent {}