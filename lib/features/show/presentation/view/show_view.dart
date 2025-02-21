// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
// import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

// class ShowView extends StatefulWidget {
//   const ShowView({super.key});

//   @override
//   State<ShowView> createState() => _ShowViewState();
// }

// class _ShowViewState extends State<ShowView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ShowBloc>().add(LoadShows()); // ✅ Fetch showtime details
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Show Booking'),
//         ),
//         backgroundColor: Colors.black, // Or your desired background color
//         body: BlocBuilder<ShowBloc, ShowState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state.error != null) {
//               return Center(child: Text("Error: ${state.error}"));
//             }

//             if (state.shows.isEmpty) {
//               return const Center(child: Text("No shows available"));
//             }

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Select Date',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 6, 6, 6)),
//                     ),
//                     _buildDateSelection(state.shows),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Select Cinema',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 6, 6, 6)),
//                     ),
//                     const SizedBox(height: 16),
//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: state.shows
//                           .map((show) => show.hall.hall_name)
//                           .toSet()
//                           .map((hallName) => _buildCinemaCard(hallName))
//                           .toList(),
//                     ),
//                     const SizedBox(height: 24),

//                     const Text(
//                       'Show Time',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 8, 8, 8)),
//                     ),
//                     const SizedBox(height: 16),
//                     Wrap(
//                       spacing: 12,
//                       runSpacing: 12,
//                       children: state.shows
//                           .map((show) => _buildTimeCard(
//                               "${show.start_time} - ${show.end_time}"))
//                           .toList(),
//                     ),

//                     const SizedBox(height: 24),
//                     // 🎥 List of Available Movies for Selection
//                     const Text(
//                       'Available Movies',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//   }

//   /// 📅 Build Dynamic Date Selection
//   Widget _buildDateSelection(List<ShowEntity> shows) {
//     List<String> uniqueDates = shows.map((show) => show.date).toSet().toList();

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: uniqueDates.map((date) {
//           return _buildDateCard(
//             date: _formatDate(date),
//             fullDate: date,
//             isSelected: uniqueDates.first == date,
//           );
//         }).toList(),
//       ),
//     );
//   }

//   /// 🗓️ Format Date Properly
//   String _formatDate(String date) {
//     try {
//       DateTime parsedDate = DateTime.parse(date);
//       return DateFormat("dd MMM yyyy").format(parsedDate);
//     } catch (e) {
//       return date; // Fallback if parsing fails
//     }
//   }

//   Widget _buildDateCard({
//     required String date,
//     required String fullDate,
//     bool isSelected = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.blue : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.blue, width: 1),
//       ),
//       child: Column(
//         children: [
//           Text(date,
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold)),
//           Text(fullDate,
//               style: const TextStyle(color: Colors.black70, fontSize: 12)),
//         ],
//       ),
//     );
//   }

//   Widget _buildCinemaCard(String name) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//           color: Colors.blue, borderRadius: BorderRadius.circular(8)),
//       child:
//           Text(name, style: const TextStyle(color: Colors.black, fontSize: 14)),
//     );
//   }

//   Widget _buildTimeCard(String time) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//           color: Colors.orange, borderRadius: BorderRadius.circular(8)),
//       child:
//           Text(time, style: const TextStyle(color: Colors.black, fontSize: 14)),
//     );
//   }
// }
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
  String? selectedDate;
  String? selectedHall;
  String? selectedTime;
  String? selectedMovie;

  @override
  void initState() {
    super.initState();
    context.read<ShowBloc>().add(LoadShows());
    // Set initial selected date to 2 days from now
    selectedDate =
        DateTime.now().add(const Duration(days: 2)).toString().split(' ')[0];
  }

  void _navigateToSeatBooking() {
    if (selectedHall != null && selectedTime != null && selectedMovie != null) {
      // Navigate to seat booking screen with selected details
      Navigator.pushNamed(
        context,
        '/seat-booking',
        arguments: {
          'hall': selectedHall,
          'time': selectedTime,
          'movie': selectedMovie,
          'date': selectedDate,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all booking details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSelection(state.shows),
                  const SizedBox(height: 24),
                  _buildHallAndTimeSection(state.shows),
                  const SizedBox(height: 24),
                  _buildMovieSection(state.shows),
                  const SizedBox(height: 32),
                  _buildBookingButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateSelection(List<ShowEntity> shows) {
    // Generate dates starting from 2 days ahead
    final dates = List.generate(3, (index) {
      return DateTime.now().add(Duration(days: index));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dates.map((date) {
              final dateStr = date.toString().split(' ')[0];
              return _buildDateCard(
                date: _formatDate(dateStr),
                fullDate: dateStr,
                isSelected: selectedDate == dateStr,
                onTap: () => setState(() => selectedDate = dateStr),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHallAndTimeSection(List<ShowEntity> shows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Cinema & Show Time',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 16),
        ...shows
            .map((show) => show.hall.hall_name)
            .toSet()
            .map((hallName) => _buildHallTimeCard(
                  hallName,
                  shows
                      .where((show) =>
                          show.hall.hall_name == hallName &&
                          show.date == selectedDate)
                      .toList(),
                )),
      ],
    );
  }

  Widget _buildHallTimeCard(String hallName, List<ShowEntity> hallShows) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              hallName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(color: Colors.blue),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: hallShows.map((show) {
                final timeSlot = "${show.start_time} - ${show.end_time}";
                return GestureDetector(
                  onTap: () => setState(() {
                    selectedHall = hallName;
                    selectedTime = timeSlot;
                  }),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          selectedHall == hallName && selectedTime == timeSlot
                              ? Colors.orange
                              : Colors.orange.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      timeSlot,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 235, 22, 22),
                          fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection(List<ShowEntity> shows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Movies',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: shows
                .map((show) => show.movie)
                .toSet()
                .map((movie) => _buildMovieCard(
                      movie,
                      isSelected: selectedMovie == movie.movie_name,
                      onTap: () =>
                          setState(() => selectedMovie = movie.movie_name),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDateCard({
    required String date,
    required String fullDate,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: Column(
          children: [
            Text(date,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Text(fullDate,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCard(
    dynamic movie, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_getImageUrl(movie?.movie_image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.8),
                        Colors.transparent
                      ],
                    ),
                  ),
                  child: Text(movie?.movie_name ?? "Unknown",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _navigateToSeatBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Continue to Seat Selection',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat("dd MMM yyyy").format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  String _getImageUrl(String? imagePath) {
    const String baseUrl = "http://192.168.137.1:4011/public/uploads/images/";
    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}
