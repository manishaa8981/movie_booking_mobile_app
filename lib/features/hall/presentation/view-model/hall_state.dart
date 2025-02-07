part of 'hall_bloc.dart';

class HallState extends Equatable {
  final List<HallEntity> halls;
  final bool isLoading;
  final String? error;

  const HallState({
    required this.halls,
    required this.isLoading,
    this.error,
  });

  factory HallState.initial() {
    return HallState(
      halls: [],
      isLoading: false,
    );
  }

  HallState copyWith({
    List<HallEntity>? batches,
    bool? isLoading,
    String? error,
  }) {
    return HallState(
      halls: halls ?? halls,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [halls, isLoading, error];
}
