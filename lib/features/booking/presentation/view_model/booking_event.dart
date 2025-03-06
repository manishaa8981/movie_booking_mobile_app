part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

final class LoadBookings extends BookingEvent {}

final class AddBooking extends BookingEvent {
  final String customerId;
  final List<SeatEntity> seats;
  final ShowEntity showtimeId;
  final String paymentStatus;
  final int totalPrice;

  const AddBooking( {required this.customerId,required  this.seats,required this.showtimeId,required this.paymentStatus, required this.totalPrice});

  @override
  List<Object> get props => [customerId , seats , showtimeId , paymentStatus , totalPrice] ;
}




