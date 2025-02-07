part of 'show_bloc.dart';

class ShowState extends Equatable {
  final List<ShowEntity> shows;
  final bool isLoading;
  final String? error;

  const ShowState({
    required this.shows,
    required this.isLoading,
    this.error,
  });

  factory ShowState.initial() {
    return ShowState(
      shows: [],
      isLoading: false,
    );
  }

  ShowState copyWith({
    List<ShowEntity>? shows,
    bool? isLoading,
    String? error,
  }) {
    return ShowState(
      shows: shows ?? this.shows,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [shows, isLoading, error];
}
