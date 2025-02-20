import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/domain/usecase/get_all_seat_usecase.dart';

part 'seat_event.dart';
part 'seat_state.dart';

class SeatBloc extends Bloc<SeatEvent, SeatState> {
  final GetAllSeatUsecase _getAllSeatUsecase;

  SeatBloc(this._getAllSeatUsecase) : super(SeatState.initial()) {
    on<LoadSeats>(_onLoadSeats);
  }

  Future<void> _onLoadSeats(LoadSeats event, Emitter<SeatState> emit) async {
    emit(state.copyWith(isLoading: true));

    final Either<Failure, List<SeatEntity>> result =
        await _getAllSeatUsecase.call(event.hallId);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (seats) => emit(state.copyWith(isLoading: false, seats: seats, error: null)),
    );
  }
}
