import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/usecase/get_all_seat_usecase.dart';

part 'seat_event.dart';
part 'seat_state.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final GetAllSeatUsecase _getAllSeatUsecase;

  SeatBloc({
    required GetAllSeatUsecase getAllSeatUsecase,
  })  : _getAllSeatUsecase = getAllSeatUsecase,
        super(SeatState.initial()) {
    on<LoadSeats>(_onLoadSeats);
  }

  Future<void> _onLoadSeats(LoadSeats event, Emitter<SeatState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllSeatUsecase.call();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (seats) => emit(state.copyWith(
        isLoading: false,
        error: null,
        seats : seats
      )),
    );
  }
}
