import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    // Set initial date to today
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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

    Navigator.pushNamed(
      context,
      '/seat-layout',
      arguments: {
        'showId': selectedShow!.showId,
        'hallId': selectedShow!.hall.hallId,
        'movieId': selectedShow!.movie.movieId,
        'showTime': "${selectedShow!.start_time} - ${selectedShow!.end_time}",
        'date': selectedShow!.date,
        'hallName': selectedShow!.hall.hall_name,
        'movieName': selectedShow!.movie.movie_name,
        'movieImage': selectedShow!.movie.movie_image,
        'price': selectedShow!.hall.price,
      },
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
      appBar: AppBar(
        title: const Text('Book Show'),
        elevation: 0,
      ),
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const _LoadingView();
          }

          if (state.error != null) {
            return _ErrorView(
              error: state.error!,
              onRetry: () => context.read<ShowBloc>().add(LoadShows()),
            );
          }

          if (state.shows.isEmpty) {
            return const _EmptyView();
          }

          final showsByDate = _groupShowsByDate(state.shows);
          final filteredShows =
              state.shows.where((show) => show.date == selectedDate).toList();

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ShowBloc>().add(LoadShows()),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateSelectionWidget(
                            dates: showsByDate.keys.toList(),
                            selectedDate: selectedDate,
                            onDateSelected: _handleDateSelection,
                          ),
                          const SizedBox(height: 24),
                          if (selectedShow != null) ...[
                            MovieInfoCard(movie: selectedShow!.movie),
                            const SizedBox(height: 24),
                          ],
                          ShowTimesGrid(
                            shows: filteredShows,
                            selectedShow: selectedShow,
                            onShowSelected: _handleShowSelection,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BottomBookingBar(
                selectedShow: selectedShow,
                onBookingPressed: _navigateToSeatBooking,
              ),
            ],
          );
        },
      ),
    );
  }

  Map<String, List<ShowEntity>> _groupShowsByDate(List<ShowEntity> shows) {
    return shows.fold<Map<String, List<ShowEntity>>>(
      {},
      (map, show) {
        if (!map.containsKey(show.date)) {
          map[show.date] = [];
        }
        map[show.date]!.add(show);
        return map;
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error: $error",
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No shows available",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class DateSelectionWidget extends StatelessWidget {
  final List<String> dates;
  final String? selectedDate;
  final ValueChanged<String> onDateSelected;

  const DateSelectionWidget({
    super.key,
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              return DateCard(
                date: date,
                isSelected: date == selectedDate,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DateCard extends StatelessWidget {
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateCard({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.parse(date);
    final bool isToday = dateTime.difference(DateTime.now()).inDays == 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isToday ? 'Today' : DateFormat('EEE').format(dateTime),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('d').format(dateTime),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('MMM').format(dateTime),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieInfoCard extends StatelessWidget {
  final dynamic movie;

  const MovieInfoCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _getImageUrl(movie.movie_image),
              width: 80,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 120,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.movie, size: 40),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.movie_name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Duration: ${movie.duration ?? "N/A"}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getImageUrl(String? imagePath) {
    const String baseUrl = "http://192.168.137.1:4011/public/uploads/images/";
    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}

class ShowTimesGrid extends StatelessWidget {
  final List<ShowEntity> shows;
  final ShowEntity? selectedShow;
  final ValueChanged<ShowEntity> onShowSelected;

  const ShowTimesGrid({
    super.key,
    required this.shows,
    required this.selectedShow,
    required this.onShowSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<ShowEntity>> showsByHall = _groupShowsByHall(shows);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Show Time',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...showsByHall.entries.map((entry) => HallShowTimes(
              hallName: entry.key,
              shows: entry.value,
              selectedShow: selectedShow,
              onShowSelected: onShowSelected,
            )),
      ],
    );
  }

  Map<String, List<ShowEntity>> _groupShowsByHall(List<ShowEntity> shows) {
    return shows.fold<Map<String, List<ShowEntity>>>(
      {},
      (map, show) {
        if (!map.containsKey(show.hall.hall_name)) {
          map[show.hall.hall_name] = [];
        }
        map[show.hall.hall_name]!.add(show);
        return map;
      },
    );
  }
}

class HallShowTimes extends StatelessWidget {
  final String hallName;
  final List<ShowEntity> shows;
  final ShowEntity? selectedShow;
  final ValueChanged<ShowEntity> onShowSelected;

  const HallShowTimes({
    super.key,
    required this.hallName,
    required this.shows,
    required this.selectedShow,
    required this.onShowSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hallName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: shows
                .map((show) => ShowTimeButton(
                      show: show,
                      isSelected: selectedShow?.showId == show.showId,
                      onTap: () => onShowSelected(show),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ShowTimeButton extends StatelessWidget {
  final ShowEntity show;
  final bool isSelected;
  final VoidCallback onTap;

  const ShowTimeButton({
    super.key,
    required this.show,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          show.start_time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class BottomBookingBar extends StatelessWidget {
  final ShowEntity? selectedShow;
  final VoidCallback onBookingPressed;

  const BottomBookingBar({
    super.key,
    required this.selectedShow,
    required this.onBookingPressed,
  });

  @override
  Widget build(BuildContext context) {
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
          children: [
            if (selectedShow != null) ...[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Price: \$${selectedShow!.hall.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      selectedShow!.hall.hall_name,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: selectedShow != null ? onBookingPressed : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: Text(
                  selectedShow != null ? 'Select Seats' : 'Select a Show Time',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
