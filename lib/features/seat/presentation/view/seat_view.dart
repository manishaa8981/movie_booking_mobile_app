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

  @override
  void initState() {
    super.initState();
    context.read<SeatBloc>().add(LoadSeats(hallId: widget.hallId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Theme Data
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          "Select Seats - ${widget.hallName}",
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SeatBloc, SeatState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child:
                  CircularProgressIndicator(color: theme.colorScheme.primary),
            );
          }

          if (state.error != null) {
            return Center(
              child: Text("Error: ${state.error}",
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
            );
          }

          final seats = state.seats;
          if (seats.isEmpty) {
            return Center(
              child:
                  Text("No seats available", style: theme.textTheme.bodyLarge),
            );
          }

          final maxRow = seats.fold<int>(
              0, (max, seat) => seat.seatRow! > max ? seat.seatRow! : max);
          final maxColumn = seats.fold<int>(0,
              (max, seat) => seat.seatColumn! > max ? seat.seatColumn! : max);

          return Column(
            children: [
              const SizedBox(height: 24),
              _buildScreenIndicator(theme),
              const SizedBox(height: 40),
              _buildSeatGrid(seats, maxRow, maxColumn, theme, isDarkMode),
              const SizedBox(height: 32),
              _buildLegend(theme),
              _buildBottomBar(theme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScreenIndicator(ThemeData theme) {
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
      child: Center(
        child: Text(
          "SCREEN",
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSeatGrid(List<SeatEntity> seats, int rows, int columns,
      ThemeData theme, bool isDarkMode) {
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

              return _buildSeatWidget(seat, theme, isDarkMode);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSeatWidget(SeatEntity seat, ThemeData theme, bool isDarkMode) {
    bool isSelected = selectedSeats.contains(seat.seatName);
    bool isBooked = seat.seatStatus ?? false;

    Color seatColor = isBooked
        ? Colors.red
        : isSelected
            ? theme.colorScheme.primary
            : isDarkMode
                ? Colors.grey[800]!
                : Colors.grey.shade400;

    return GestureDetector(
      onTap: () {
        if (!isBooked && seat.seatName != null) {
          setState(() {
            if (isSelected) {
              selectedSeats.remove(seat.seatName);
            } else {
              selectedSeats.add(seat.seatName!);
            }
          });
        }
      },
      child: Icon(
        Icons.chair, // Sofa Icon
        size: 32,
        color: seatColor,
      ),
    );
  }

  Widget _buildLegend(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem("Available", Colors.grey.shade400, theme),
          _buildLegendItem("Selected", theme.colorScheme.primary, theme),
          _buildLegendItem("Booked", Colors.red, theme),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, ThemeData theme) {
    return Row(
      children: [
        Icon(Icons.chair, color: color, size: 24),
        const SizedBox(width: 8),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    final seatCount = selectedSeats.length;
    final totalPrice = seatCount * widget.price;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$seatCount Seats Selected",
                      style: theme.textTheme.bodyLarge),
                  if (seatCount > 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      "Total: Rs.${totalPrice.toStringAsFixed(2)}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.primary),
                    ),
                  ],
                ],
              ),
            ),
            ElevatedButton(
              onPressed: selectedSeats.isNotEmpty ? _confirmSelection : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary),
              child:
                  Text("Confirm Selection", style: theme.textTheme.bodyLarge),
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
