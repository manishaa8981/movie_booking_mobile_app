// import 'package:flutter/material.dart';
// import 'package:movie_ticket_booking/features/seat/presentation/view/ticket_view.dart';

// class PaymentView extends StatefulWidget {
//   final List<String> selectedSeats;
//   final int totalPrice;

//   const PaymentView({super.key, required this.selectedSeats, required this.totalPrice});

//   @override
//   State<PaymentView> createState() => _PaymentViewState();
// }

// class _PaymentViewState extends State<PaymentView> {
//   String selectedPaymentMethod = "Credit Card"; // Default payment method

//   final List<String> paymentMethods = [
//     "Credit Card",
//     "UPI",
//     "Net Banking",
//     "Wallet"
//   ];

//   void _processPayment() {
//     // Simulate a successful payment
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => TicketView(
//             selectedSeats: widget.selectedSeats,
//             totalPrice: widget.totalPrice,
//           ),
//         ),
//       );
//     });

//     // Show a processing dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.black,
//           title: const Text("Processing Payment...", style: TextStyle(color: Colors.white)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               CircularProgressIndicator(color: Colors.orange),
//               SizedBox(height: 16),
//               Text("Please wait", style: TextStyle(color: Colors.white70))
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             const Text(
//               "Booking Summary",
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),

//             // 📌 Booking Details Box
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildBookingDetail("Selected Seats", widget.selectedSeats.join(", ")),
//                   _buildBookingDetail("Total Amount", "₹${widget.totalPrice}"),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             const Text(
//               "Select Payment Method",
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),

//             // 📌 Payment Method Selection
//             Column(
//               children: paymentMethods.map((method) {
//                 return RadioListTile<String>(
//                   title: Text(method, style: const TextStyle(color: Colors.white)),
//                   value: method,
//                   groupValue: selectedPaymentMethod,
//                   activeColor: Colors.orange,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPaymentMethod = value!;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),

//             const Spacer(),

//             // 📌 Confirm Payment Button
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _processPayment,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: const Text(
//                   "Pay Now",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBookingDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
//           Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }
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
  String selectedPaymentMethod = "Credit Card"; // Default method

  final List<String> paymentMethods = [
    "Credit Card",
    "UPI",
    "Net Banking",
    "Wallet"
  ];

  void _processPayment() {
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
            hallName: widget.hallName, // ✅ Pass real theater name
            date: widget.date, // ✅ Pass real date
            time: widget.time, // ✅ Pass real time
            showId: widget.showId, // ✅ Pass real show ID
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader("Booking Summary"),
              _buildBookingDetails(),
              const SizedBox(height: 20),
              _buildHeader("Select Payment Method"),
              _buildPaymentMethods(),
              const Spacer(),
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
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Movie", widget.movieName), // ✅ Show movie name
          _buildDetailRow("Theater", widget.hallName), // ✅ Show theater name
          _buildDetailRow("Date", widget.date), // ✅ Show real date
          _buildDetailRow("Time", widget.time), // ✅ Show real time
          _buildDetailRow(
              "Seats", widget.selectedSeats.join(", ")), // ✅ Show real seats
          _buildDetailRow("Total Amount", "₹${widget.totalPrice}"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: paymentMethods.map((method) {
        return RadioListTile<String>(
          title: Text(method, style: const TextStyle(color: Colors.white)),
          value: method,
          groupValue: selectedPaymentMethod,
          activeColor: Colors.orange,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
            });
          },
        );
      }).toList(),
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
        child: const Text(
          "Pay Now",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
