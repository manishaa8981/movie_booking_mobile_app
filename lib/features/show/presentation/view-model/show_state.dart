part of 'show_bloc.dart';
class ShowState extends Equatable {
  final List<ShowEntity> shows;
  final bool isLoading;
  final String? error;
  final String? selectedHall; // New
  final String? selectedTime; // New

  const ShowState({
    required this.shows,
    required this.isLoading,
    this.error,
    this.selectedHall,
    this.selectedTime,
  });

  factory ShowState.initial() {
    return ShowState(
      shows: [],
      isLoading: false,
      selectedHall: null,
      selectedTime: null,
    );
  }

  ShowState copyWith({
    List<ShowEntity>? shows,
    bool? isLoading,
    String? error,
    String? selectedHall,
    String? selectedTime,
  }) {
    return ShowState(
      shows: shows ?? this.shows,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedHall: selectedHall ?? this.selectedHall,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props => [shows, isLoading, error, selectedHall, selectedTime];
}
