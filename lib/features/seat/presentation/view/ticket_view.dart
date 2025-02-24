import 'package:flutter/material.dart';

class TicketView extends StatelessWidget {
  final List<String> selectedSeats;
  final int totalPrice;
  final String movieName;
  final String hallName;
  final String date;
  final String time;
  final String showId;

  const TicketView({
    super.key,
    required this.selectedSeats,
    required this.totalPrice,
    required this.movieName,
    required this.hallName,
    required this.date,
    required this.time,
    required this.showId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          "Your Ticket",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Upper part of ticket
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/cinema_logo.png', // Add your cinema logo
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.movie,
                                        size: 40, color: Colors.orange),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hallName, // ✅ Show real theater name
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Show ID: $showId",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movieName, // ✅ Show real movie name
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider with circles
                    Stack(
                      children: [
                        Container(
                          height: 30,
                          color: Colors.black,
                          child: Row(
                            children: List.generate(
                              30,
                              (index) => Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    height: 2,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -15,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -15,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Lower part of ticket
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow("Date", date), // ✅ Show real date
                          _buildInfoRow("Time", time), // ✅ Show real time
                          _buildInfoRow("Seats",
                              selectedSeats.join(", ")), // ✅ Show real seats
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "₹$totalPrice",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/qr_code.png', // Add your QR code image
                                width: 80,
                                height: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.qr_code_2,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Please arrive 30 minutes before showtime. "
                      "Booking ID: ",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
            ),
          ),
          const Text(
            ": ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
