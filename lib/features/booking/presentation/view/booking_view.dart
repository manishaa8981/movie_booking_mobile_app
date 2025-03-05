import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/booking/domain/entity/booking_entity.dart';
import 'package:movie_ticket_booking/features/booking/presentation/view_model/booking_bloc.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.bookings.isEmpty) {
            return const Center(
              child: Text(
                "No Bookings Found!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.bookings.length,
            itemBuilder: (context, index) {
              final booking = state.bookings[index];
              return _buildBookingCard(booking);
            },
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(BookingEntity booking) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking ID: ${booking.id ?? "N/A"}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Customer ID: ${booking.customerId}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              "Showtime: ${booking.showtimeId.start_time ?? "Unknown"}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              "Seats: ${booking.seats.map((seat) => seat.seatName).join(", ")}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              "Total Price: \$${booking.totalPrice}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Payment Status: ${booking.paymentStatus}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: booking.paymentStatus.toLowerCase() == "paid"
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
