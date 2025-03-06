import 'package:flutter/material.dart';

class BookingView extends StatelessWidget {
  final List<BookingItem> bookings = [
    BookingItem(
      id: 1,
      movie: "Bool Bhuliya",
      date: "5 March, 2025",
      time: "10:00 AM",
      price: "Rs. 750",
      seats: 'E1 , E2',
    ),
    BookingItem(
      id: 2,
      movie: "GODZILLA VS KONG",
      date: "5 June, 21",
      time: "9:30 PM",
      price: "Rs. 750",
      seats: 'E1 , E2',
    ),
    BookingItem(
      id: 3,
      movie: "GODZILLA VS KONG",
      date: "6 June, 21",
      time: "9:30 PM",
      price: "Rs. 750",
      seats: 'E1 , E2',
    ),
    BookingItem(
      id: 4,
      movie: "GODZILLA VS KONG",
      date: "6 June, 21",
      time: "7:30 PM",
      price: "Rs. 750",
      seats: 'E1 , E2',
    ),
  ];

  BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          'Your Bookings',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: BookingCard(booking: bookings[index]),
            );
          },
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final BookingItem booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // // Movie Poster
          // ClipRRect(
          //   borderRadius: const BorderRadius.only(
          //     topLeft: Radius.circular(12),
          //     bottomLeft: Radius.circular(12),
          //   ),
          //   child: Image.asset(
          //     'assets/godzilla_kong.jpg',
          //     width: 100,
          //     height: 120,
          //     fit: BoxFit.cover,
          //   ),
          // ),

          // Booking Details (Expanded to prevent overflow)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.movie,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${booking.date} | ${booking.time}",
                          style: textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.monetization_on,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        booking.price,
                        style: textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Seats (Fixed Width)
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_seat, color: Colors.white, size: 24),
                const SizedBox(height: 6),
                Text(
                  booking.seats.toString(),
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingItem {
  final int id;
  final String movie;
  final String date;
  final String time;
  final String price;
  final String seats;

  BookingItem({
    required this.id,
    required this.movie,
    required this.date,
    required this.time,
    required this.price,
    required this.seats,
  });
}
