import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/hall/domain/entity/hall_entity.dart';
import 'package:movie_ticket_booking/features/hall/domain/usecase/get_all_hall_usecase.dart';

part 'hall_event.dart';
part 'hall_state.dart';

class HallBloc extends Bloc<HallEvent, HallState> {
  final GetAllHallUsecase _getAllHallUsecase;

  HallBloc({
    required GetAllHallUsecase getAllHallUsecase,
  })  : _getAllHallUsecase = getAllHallUsecase,
        super(HallState.initial()) {
    on<LoadHalls>(_onLoadHalls);
  }

  Future<void> _onLoadHalls(LoadHalls event, Emitter<HallState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllHallUsecase.call();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (halls) => emit(state.copyWith(
        isLoading: false,
        error: null,
      )),
    );
  }
}
