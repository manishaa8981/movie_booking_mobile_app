import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/features/seat/domain/entity/seat_entity.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view-model/seat_bloc.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view/payment_view.dart';

class SeatLayoutPage extends StatefulWidget {
  final String hallId;
  final String hallName;
  final int price;
  final String showId;
  final String movieName;

  const SeatLayoutPage({
    super.key,
    required this.hallId,
    required this.hallName,
    required this.price,
    required this.showId,
    required this.movieName,
  });

  @override
  State<SeatLayoutPage> createState() => _SeatLayoutPageState();
}

class _SeatLayoutPageState extends State<SeatLayoutPage> {
  final Set<String> selectedSeats = {}; // Store seat names instead of IDs
  static const Color primaryColor = Colors.orange;
  static const Color backgroundColor = Color(0xFFF5F5F5);

  @override
  void initState() {
    super.initState();
    context.read<SeatBloc>().add(LoadSeats(hallId: widget.hallId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text(
          "Select Seats - ${widget.hallName}",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SeatBloc, SeatState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          }

          if (state.error != null) {
            return Center(
                child: Text("Error: ${state.error}",
                    style: const TextStyle(color: Colors.red, fontSize: 16)));
          }

          final seats = state.seats;
          if (seats.isEmpty) {
            return const Center(
                child: Text("No seats available",
                    style: TextStyle(fontSize: 18, color: Colors.black54)));
          }

          final maxRow = seats.fold<int>(
              0, (max, seat) => seat.seatRow! > max ? seat.seatRow! : max);
          final maxColumn = seats.fold<int>(0,
              (max, seat) => seat.seatColumn! > max ? seat.seatColumn! : max);

          return Column(
            children: [
              const SizedBox(height: 24),
              _buildScreenIndicator(),
              const SizedBox(height: 40),
              _buildSeatGrid(seats, maxRow, maxColumn),
              const SizedBox(height: 32),
              _buildLegend(),
              _buildBottomBar(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScreenIndicator() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: const Center(
        child: Text("SCREEN",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: Colors.white)),
      ),
    );
  }

  Widget _buildSeatGrid(List<SeatEntity> seats, int rows, int columns) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (rows + 1) * (columns + 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns + 1,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final row = index ~/ (columns + 1);
              final col = index % (columns + 1);

              final seat = seats.firstWhere(
                (s) => s.seatRow == row && s.seatColumn == col,
                orElse: () => const SeatEntity.empty(),
              );

              if (seat.seatId == '_empty.seatId') {
                return const SizedBox();
              }

              return _buildSeatWidget(seat);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSeatWidget(SeatEntity seat) {
    bool isSelected =
        selectedSeats.contains(seat.seatName); // Compare seat names
    bool isBooked = seat.seatStatus ?? false;

    Color seatColor = isBooked
        ? Colors.red
        : isSelected
            ? primaryColor
            : Colors.white;

    return GestureDetector(
      onTap: () {
        if (!isBooked && seat.seatName != null) {
          setState(() {
            if (isSelected) {
              selectedSeats.remove(seat.seatName);
            } else {
              selectedSeats.add(seat.seatName!); // Store seat names
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
            seat.seatName ?? '',
            style: TextStyle(
                fontSize: 12, color: isBooked ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem("Available", Colors.white),
          _buildLegendItem("Selected", primaryColor),
          _buildLegendItem("Booked", Colors.red),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    final seatCount = selectedSeats.length;
    final totalPrice = seatCount * widget.price;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$seatCount Seats Selected",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87)),
                  if (seatCount > 0) ...[
                    const SizedBox(height: 4),
                    Text("Total: Rs.${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ),
            ElevatedButton(
              onPressed: selectedSeats.isNotEmpty ? _confirmSelection : null,
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text("Confirm Selection",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmSelection() {
    if (selectedSeats.isEmpty) return;

    final totalPrice = selectedSeats.length * widget.price;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentView(
          selectedSeats: selectedSeats.toList(),
          totalPrice: totalPrice,
          showId: widget.showId,
          movieName: widget.movieName,
          hallName: widget.hallName,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          time: DateFormat('hh:mm a').format(DateTime.now()),
        ),
      ),
    );
  }
}
