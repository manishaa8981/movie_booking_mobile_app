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
    final theme = Theme.of(context); // Get theme context
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Colors.white), // Back Button White
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Your Ticket",
          style: textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: theme.shadowColor.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Upper part of ticket
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
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
                                        size: 40, color: Colors.black),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      hallName,
                                      style: textTheme.titleLarge?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            movieName,
                            style: textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
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
                          color: theme.colorScheme.primary,
                          child: Row(
                            children: List.generate(
                              30,
                              (index) => Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    height: 2,
                                    color: theme.dividerColor,
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
                          child: _buildCircle(theme.colorScheme.surface),
                        ),
                        Positioned(
                          right: -15,
                          top: 0,
                          bottom: 0,
                          child: _buildCircle(theme.colorScheme.surface),
                        ),
                      ],
                    ),

                    // Lower part of ticket
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow("Date", date, textTheme, theme),
                          _buildInfoRow("Time", time, textTheme, theme),
                          _buildInfoRow("Seats", selectedSeats.join(", "),
                              textTheme, theme),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                    ),
                                  ),
                                  Text(
                                    "Rs.$totalPrice",
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/qr_code.png', // Add QR code image
                                width: 80,
                                height: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: theme.dividerColor),
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
                      "Please arrive 30 minutes before showtime. Booking ID: ",
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
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
                  child: Text(
                    "Back to Home",
                    style: textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSecondary,
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

  Widget _buildInfoRow(
      String label, String value, TextTheme textTheme, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ),
          const Text(": ", style: TextStyle(color: Colors.grey, fontSize: 14)),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color backgroundColor) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
