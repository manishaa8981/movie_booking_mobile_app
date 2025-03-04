import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view/ticket_view.dart';

class PaymentView extends StatefulWidget {
  final List<String> selectedSeats;
  final int totalPrice;
  final String movieName;
  final String hallName;
  final String date;
  final String time;
  final String showId;

  const PaymentView({
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
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Show Processing Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text("Processing Payment...",
                style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(color: Colors.orange),
                SizedBox(height: 16),
                Text("Please wait", style: TextStyle(color: Colors.white70)),
              ],
            ),
          );
        },
      );

      // Simulate payment process
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); // Close dialog

        // ✅ Navigate to `TicketView` with real data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TicketView(
              selectedSeats: widget.selectedSeats,
              totalPrice: widget.totalPrice,
              movieName: widget.movieName,
              hallName: widget.hallName,
              date: widget.date,
              time: widget.time,
              showId: widget.showId,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader("Payment Details"),
              _buildBookingDetails(theme, isDarkMode),
              const SizedBox(height: 20),
              _buildHeader("Enter Card Details"),
              _buildPaymentForm(),
              const SizedBox(height: 20),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBookingDetails(ThemeData theme, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("🎥 Movie", widget.movieName),
          _buildDetailRow("🏛️ Theater", widget.hallName),
          _buildDetailRow("📅 Date", widget.date),
          _buildDetailRow("⏰ Time", widget.time),
          _buildDetailRow("💺 Seats", widget.selectedSeats.join(", ")),
          const Divider(color: Colors.grey),
          _buildDetailRow("💰 Total", "₹${widget.totalPrice}",
              isBold: true, fontSize: 18),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isBold = false, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField("Card Number", "1234 5678 9012 3456",
                TextInputType.number, Icons.credit_card),
            _buildTextField("Card Holder Name", "John Doe", TextInputType.text,
                Icons.person),
            Row(
              children: [
                Expanded(
                    child: _buildTextField("Expiry Date", "MM/YY",
                        TextInputType.datetime, Icons.date_range)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildTextField(
                        "CVV", "***", TextInputType.number, Icons.security,
                        isPassword: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextInputType inputType, IconData icon,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 20),
            const SizedBox(width: 8),
            Text(
              "Pay ₹${widget.totalPrice}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
