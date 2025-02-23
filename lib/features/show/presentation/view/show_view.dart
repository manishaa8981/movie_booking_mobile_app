import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    selectedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now()); // Set default date
    context.read<ShowBloc>().add(LoadShows());
  }

  void _handleDateSelection(String date) {
    setState(() {
      selectedDate = date;
      selectedShow = null; // Reset show selection when date changes
    });
  }

  void _handleShowSelection(ShowEntity show) {
    setState(() {
      selectedShow = show;
    });
  }

  void _navigateToSeatBooking() {
    if (selectedShow == null) {
      _showErrorSnackBar('Please select a show time to continue');
      return;
    }

    // ✅ Navigate to SeatLayoutPage and pass required data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatLayoutPage(
          // showId: selectedShow!.showId,
          // hallId: selectedShow!.hall.hallId,
          hallName: selectedShow!.hall.hall_name,
          // movieId: selectedShow!.movie.movieId,
          // movieName: selectedShow!.movie.movie_name,
          // movieImage: selectedShow!.movie.movie_image,
          // showTime: "${selectedShow!.start_time} - ${selectedShow!.end_time}",
          // date: selectedShow!.date,
          // price: selectedShow!.hall.price,
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Show'), elevation: 0),
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state.isLoading)
            return const Center(child: CircularProgressIndicator());
          if (state.error != null)
            return Center(child: Text("Error: ${state.error}"));
          if (state.shows.isEmpty)
            return const Center(child: Text("No shows available"));

          final showsByDate = _groupShowsByDate(state.shows);
          final filteredShows =
              state.shows.where((show) => show.date == selectedDate).toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDateSelection(showsByDate.keys.toList()),
                      const SizedBox(height: 24),
                      if (selectedShow != null) ...[
                        _buildMovieInfo(selectedShow!.movie),
                        const SizedBox(height: 24),
                      ],
                      _buildShowTimes(filteredShows),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateSelection(List<String> dates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Date',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              return GestureDetector(
                onTap: () => _handleDateSelection(date),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: date == selectedDate
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat('EEE').format(DateTime.parse(date))),
                      Text(DateFormat('d MMM').format(DateTime.parse(date)),
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieInfo(dynamic movie) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            movie.movie_image ?? "https://via.placeholder.com/80x120",
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(movie.movie_name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildShowTimes(List<ShowEntity> shows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Show Time',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: shows.map((show) {
            return GestureDetector(
              onTap: () => _handleShowSelection(show),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selectedShow?.showId == show.showId
                      ? Colors.blue
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("${show.start_time} - ${show.end_time}"),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: ElevatedButton(
        onPressed: selectedShow != null ? _navigateToSeatBooking : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Select Seats',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Map<String, List<ShowEntity>> _groupShowsByDate(List<ShowEntity> shows) {
    return {
      for (var show in shows)
        show.date: [...(shows.where((s) => s.date == show.date))]
    };
  }
}
