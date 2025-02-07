part of 'seat_bloc.dart';

class SeatState extends Equatable {
  final List<SeatEntity> seats;
  final bool isLoading;
  final String? error;

  const SeatState({
    required this.seats,
    required this.isLoading,
    this.error,
  });

  factory SeatState.initial() {
    return SeatState(
      seats: [],
      isLoading: false,
    );
  }

  SeatState copyWith({
    List<SeatEntity>? seats,
    bool? isLoading,
    String? error,
  }) {
    return SeatState(
      seats: seats ?? this.seats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [seats, isLoading, error];
}
