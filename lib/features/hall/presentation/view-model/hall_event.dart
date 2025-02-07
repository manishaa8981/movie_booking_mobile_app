part of 'hall_bloc.dart';

@immutable
sealed class HallEvent extends Equatable {
  const HallEvent();

  @override
  List<Object> get props => [];
}

final class LoadHalls extends HallEvent {}


