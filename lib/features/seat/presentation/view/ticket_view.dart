import 'package:flutter/material.dart';

class TicketView extends StatelessWidget {
  final List<String> selectedSeats;
  final int totalPrice;

  const TicketView(
      {super.key, required this.selectedSeats, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Your Ticket"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.movie, size: 50, color: Colors.orange),
                const SizedBox(height: 10),
                const Text(
                  "Booking Confirmed!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Seats: ${selectedSeats.join(", ")}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "Total Paid: ₹$totalPrice",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Back to Home",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
