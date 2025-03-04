import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view/seat_view.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

class ShowView extends StatefulWidget {
  final String? movie_name;
  final String? movie_image;

  const ShowView({super.key, this.movie_name, this.movie_image});

  @override
  State<ShowView> createState() => _ShowViewState();
}

class _ShowViewState extends State<ShowView> {
  ShowEntity? selectedShow;
  String? selectedDate;
  int _selectedDateIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<ShowBloc>().add(LoadShows());
  }

  void _handleDateSelection(String date, int index) {
    setState(() {
      selectedDate = date;
      _selectedDateIndex = index;
      selectedShow = null;
    });
  }

  void _handleShowSelection(ShowEntity show) {
    setState(() {
      selectedShow = show;
    });

    // Show confirmation dialog instead of navigating immediately
    _showBookingConfirmationDialog(show);
  }

  void _showBookingConfirmationDialog(ShowEntity show) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.movie_outlined,
                    color: Colors.orange, size: 24),
                const SizedBox(width: 10),
                Text(
                  widget.movie_name ?? "Movie Title",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey, size: 18),
                const SizedBox(width: 10),
                Text(
                  DateFormat('EEEE, d MMMM yyyy')
                      .format(DateTime.parse(show.date)),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey, size: 18),
                const SizedBox(width: 10),
                Text(
                  "${show.start_time} - ${show.end_time}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.theater_comedy, color: Colors.grey, size: 18),
                const SizedBox(width: 10),
                Text(
                  show.hall.hall_name,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.grey, size: 18),
                const SizedBox(width: 10),
                Text(
                  "Rs.${show.hall.price}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToSeatBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Select Seats',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSeatBooking() {
    if (selectedShow == null) {
      mySnackBar(message: 'No show selected!', context: context);
      return;
    }

    // ✅ Ensure Hall ID and other details are not null
    final hallId = selectedShow!.hall.hallId ?? "";
    final hallName = selectedShow!.hall.hall_name ?? "Unknown Hall";
    final price = selectedShow!.hall.price ?? 0;
    final showId = selectedShow!.showId ?? "";
    final movieName = selectedShow!.movie.movie_name ?? "Unknown Movie";

    if (hallId.isEmpty || showId.isEmpty) {
      mySnackBar(message: 'Invalid show data!', context: context);
      return;
    }

    Navigator.pop(context); // Close the modal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatLayoutPage(
          hallId: hallId,
          hallName: hallName,
          price: price,
          showId: showId,
          movieName: movieName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          }
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 60, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    "Oops! Something went wrong",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error ?? "Unknown error",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<ShowBloc>().add(LoadShows()),
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            );
          }
          if (state.shows.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_filter,
                      size: 60, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    "No shows available",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Check back later for updates",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          final dates = state.shows.map((show) => show.date).toSet().toList()
            ..sort();
          final filteredShows =
              state.shows.where((show) => show.date == selectedDate).toList();

          // Group shows by time slots
          Map<String, List<ShowEntity>> groupedShows = {};
          for (var show in filteredShows) {
            final String time = "${show.start_time} - ${show.end_time}";
            if (!groupedShows.containsKey(time)) {
              groupedShows[time] = [];
            }
            groupedShows[time]!.add(show);
          }

          // Sort time slots
          final timeSlots = groupedShows.keys.toList()..sort();

          return CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMovieInfoSection(),
                    _buildCalendarStrip(dates),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                sliver: timeSlots.isEmpty
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Icon(Icons.event_busy,
                                  size: 50, color: Colors.grey.shade400),
                              const SizedBox(height: 16),
                              Text(
                                "No shows available on this date",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final time = timeSlots[index];
                            final shows = groupedShows[time]!;
                            return _buildTimeSlotSection(time, shows);
                          },
                          childCount: timeSlots.length,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor: Colors.orange,
      elevation: 0,
      title: const Text(
        'Select Showtime',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildMovieInfoSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 100,
              height: 150,
              color: Colors.grey.shade200,
              child: widget.movie_image != null
                  ? Image.network(widget.movie_image!, fit: BoxFit.cover)
                  : Icon(Icons.movie, size: 40, color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie_name ?? "Movie Title",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildTag("2h 35m", Icons.access_time_filled),
                    const SizedBox(width: 8),
                    _buildTag("U/A", Icons.family_restroom),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    const Text(
                      "8.5/10",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "IMDb",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarStrip(List<String> dates) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = index == _selectedDateIndex;
          final dateTime = DateTime.parse(date);
          final isToday =
              DateFormat('yyyy-MM-dd').format(DateTime.now()) == date;

          return GestureDetector(
            onTap: () => _handleDateSelection(date, index),
            child: Container(
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey.shade300,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(dateTime).toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('d').format(dateTime),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isToday)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.3)
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "TODAY",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.orange,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlotSection(String time, List<ShowEntity> shows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),
            ],
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shows.length,
          itemBuilder: (context, index) {
            return _buildShowCard(shows[index]);
          },
        ),
      ],
    );
  }

  Widget _buildShowCard(ShowEntity show) {
    final bool isSelected = selectedShow?.showId == show.showId;

    // Calculate seat availability (this would be dynamic in a real app)
    final int totalSeats = 100;
    final int availableSeats = 75;
    final double availability = availableSeats / totalSeats;

    // Determine availability status and color
    String availabilityText;
    Color availabilityColor;

    if (availability > 0.5) {
      availabilityText = "Available";
      availabilityColor = Colors.green;
    } else if (availability > 0.2) {
      availabilityText = "Filling Fast";
      availabilityColor = Colors.orange;
    } else {
      availabilityText = "Almost Full";
      availabilityColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.orange : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => _handleShowSelection(show),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: availabilityColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          show.hall.hall_name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (show.hall.hall_name.contains("IMAX") ||
                            show.hall.hall_name.contains("3D"))
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              show.hall.hall_name.contains("IMAX")
                                  ? "IMAX"
                                  : "3D",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: availabilityColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            availabilityText,
                            style: TextStyle(
                              fontSize: 10,
                              color: availabilityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Rs.${show.hall.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "BOOK",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
