import 'package:flutter/material.dart';

class SeatLayoutPage extends StatefulWidget {
  final String hallName;
  // Selected hall name

  const SeatLayoutPage({super.key, required this.hallName});

  @override
  State<SeatLayoutPage> createState() => _SeatLayoutPageState();
}

class _SeatLayoutPageState extends State<SeatLayoutPage> {
  final int rows = 6; // Number of seat rows
  final int columns = 8; // Number of seat columns
  final Set<String> selectedSeats = {}; // Tracks selected seats

  // Simulated seat data (randomly mark some as booked)
  final List<String> bookedSeats = ["A1", "B4", "C6", "D3", "E7"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Seats - ${widget.hallName}")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildScreenIndicator(),
          const SizedBox(height: 20),
          _buildSeatGrid(),
          const SizedBox(height: 20),
          _buildLegend(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  /// 🎬 Displays "Screen" at the top
  Widget _buildScreenIndicator() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "SCREEN",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  /// 🎟️ Builds the seat grid
  Widget _buildSeatGrid() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: rows * columns,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, // Number of seats per row
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            String seatId = _generateSeatId(index);

            return _buildSeatWidget(seatId);
          },
        ),
      ),
    );
  }

  /// 🔢 Generates seat IDs (A1, B2, C3, etc.)
  String _generateSeatId(int index) {
    String rowLetter = String.fromCharCode(65 + (index ~/ columns));
    int seatNumber = (index % columns) + 1;
    return "$rowLetter$seatNumber";
  }

  /// 🎭 Builds individual seat widget
  Widget _buildSeatWidget(String seatId) {
    bool isBooked = bookedSeats.contains(seatId);
    bool isSelected = selectedSeats.contains(seatId);

    Color seatColor = isBooked
        ? Colors.grey
        : isSelected
            ? Colors.blue
            : Colors.white;

    return GestureDetector(
      onTap: () {
        if (!isBooked) {
          setState(() {
            if (isSelected) {
              selectedSeats.remove(seatId);
            } else {
              selectedSeats.add(seatId);
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              fontSize: 12,
              color: isBooked ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  /// 🎨 Builds legend for seat colors
  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLegendItem("Available", Colors.white),
          _buildLegendItem("Selected", Colors.blue),
          _buildLegendItem("Booked", Colors.grey),
        ],
      ),
    );
  }

  /// 🔖 Single legend item
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  /// ✅ Bottom bar with selected seats & confirm button
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Selected: ${selectedSeats.length}",
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: selectedSeats.isNotEmpty ? _confirmSelection : null,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Confirm seat selection
  void _confirmSelection() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Seats selected: ${selectedSeats.join(', ')}"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
