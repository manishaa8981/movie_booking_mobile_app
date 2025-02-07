part of 'show_bloc.dart';
@immutable
sealed class ShowEvent extends Equatable {
  const ShowEvent();

  @override
  List<Object> get props => [];
}

final class LoadShows extends ShowEvent {}