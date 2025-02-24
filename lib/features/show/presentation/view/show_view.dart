import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/features/seat/presentation/view/seat_view.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

class ShowView extends StatefulWidget {
  const ShowView({super.key});

  @override
  State<ShowView> createState() => _ShowViewState();
}

class _ShowViewState extends State<ShowView> {
  ShowEntity? selectedShow;
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<ShowBloc>().add(LoadShows());
  }

  void _handleDateSelection(String date) {
    setState(() {
      selectedDate = date;
      selectedShow = null;
    });
  }

  void _handleShowSelection(ShowEntity show) {
    setState(() {
      selectedShow = show;
      selectedDate = show.date;
    });

    // Navigate immediately when a show is selected
    _navigateToSeatBooking();
  }

  void _navigateToSeatBooking() {
    if (selectedShow == null || selectedShow!.hall.hallId == null) {
      mySnackBar(
        message: 'Hall ID is missing!',
        context: context,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatLayoutPage(
          hallId: selectedShow!.hall.hallId ?? "", // ✅ Ensure it's not null
          hallName: selectedShow!.hall.hall_name ?? "Unknown Hall",
          price: selectedShow!.hall.price ?? 0, // ✅ Default value
          showId: selectedShow!.showId ?? "", // ✅ Pass show ID
          movieName: selectedShow!.movie.movie_name ??
              "Unknown Movie", // ✅ Pass movie name
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Show'), elevation: 0),
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          }
          if (state.shows.isEmpty) {
            return const Center(child: Text("No shows available"));
          }

          final dates = state.shows.map((show) => show.date).toSet().toList()
            ..sort();
          final filteredShows =
              state.shows.where((show) => show.date == selectedDate).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildDateSelector(dates),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredShows.length,
                  itemBuilder: (context, index) {
                    final show = filteredShows[index];
                    return _buildShowTimeCard(show);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateSelector(List<String> dates) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date == selectedDate;
          final dateTime = DateTime.parse(date);

          return GestureDetector(
            onTap: () => _handleDateSelection(date),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(dateTime),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d MMM').format(dateTime),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 14,
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

  Widget _buildShowTimeCard(ShowEntity show) {
    final isSelected = selectedShow?.showId == show.showId;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.hall.hall_name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${show.start_time} - ${show.end_time}",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
