import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/app/shared_prefs/user_shared_prefs.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/booking/domain/usecase/create_booking_usecase.dart';
import 'package:movie_ticket_booking/features/booking/domain/usecase/get_bookings_usecase.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUseCase _createBookingUseCase;
  final GetBookingsUseCase _getBookingsUseCase;

  BookingBloc({
    required CreateBookingUseCase createBookingUseCase,
    required GetBookingsUseCase getBookingUseCase,
    required UserSharedPrefs userSharedPrefs,
  })  : _createBookingUseCase = createBookingUseCase,
        _getBookingsUseCase = getBookingUseCase,
        super(BookingState.initial()) {
    on<LoadBookings>(_onLoadBookings);
    on<AddBooking>(_onAddBooking);
   
    add(LoadBookings());
  }

  

    Future<void> _onLoadBookings(
      LoadBookings event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getBookingsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (bookings) => emit(state.copyWith(isLoading: false, bookings: bookings)),
    );
  }

  Future<void> _onAddBooking(
      AddBooking event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _createBookingUseCase.call(
      CreateBookingParams(
        customerId: event.customerId,
        seats: event.seats,
        paymentStatus: event.paymentStatus,
        showtimeId: event.showtimeId, totalPrice: event.totalPrice,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBookings());
      },
    );
  } 
    
}
