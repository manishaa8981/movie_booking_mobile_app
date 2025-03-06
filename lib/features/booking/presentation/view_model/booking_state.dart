part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final List<BookingEntity> bookings;
  final bool isLoading;
  final String? error;
  final String? customerId;

  const BookingState({
    required this.bookings,
    required this.isLoading,
    this.error,
    this.customerId,
  });

  factory BookingState.initial() {
    return BookingState(
      bookings: [],
      isLoading: false,
      customerId: null,
    );
  }

  BookingState copyWith({
    List<BookingEntity>? bookings,
    bool? isLoading,
    String? error,
    String? customerId,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      customerId: customerId ?? this.customerId,
    );
  }

  @override
  List<Object?> get props => [bookings, isLoading, error , customerId];
}
