part of 'show_bloc.dart';
@immutable
sealed class ShowEvent extends Equatable {
  const ShowEvent();

  @override
  List<Object> get props => [];
}

final class LoadShows extends ShowEvent {}
final class SelectHall extends ShowEvent {
  final String hallName;

  const SelectHall(this.hallName);

  @override
  List<Object> get props => [hallName];
}

final class SelectTime extends ShowEvent {
  final String timeSlot;

  const SelectTime(this.timeSlot);

  @override
  List<Object> get props => [timeSlot];
}
