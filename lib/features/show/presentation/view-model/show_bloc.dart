import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/usecase/get_all_show.dart';

part 'show_event.dart';
part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  final GetAllShowUseCase _getAllShowUseCase;

  ShowBloc({
    required GetAllShowUseCase getAllShowUseCase,
  })  : _getAllShowUseCase = getAllShowUseCase,
        super(ShowState.initial()) {
    on<LoadShows>(_onLoadShows);
    on<SelectHall>(_onSelectHall); // ✅ Register event handler
    on<SelectTime>(_onSelectTime); // New
  }

  void _onLoadShows(LoadShows event, Emitter<ShowState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllShowUseCase.call();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
        shows: [], // Clear shows on error
      )),
      (shows) =>
          emit(state.copyWith(isLoading: false, shows: shows, error: null)),
    );
  }

  void _onSelectHall(SelectHall event, Emitter<ShowState> emit) {
    print("Event received: Selected Hall -> ${event.hallName}"); // ✅ Debugging
    emit(state.copyWith(selectedHall: event.hallName, selectedTime: null));
  }

  void _onSelectTime(SelectTime event, Emitter<ShowState> emit) {
    emit(state.copyWith(selectedTime: event.timeSlot));
  }
}
