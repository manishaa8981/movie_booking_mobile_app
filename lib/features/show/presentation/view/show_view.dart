// import 'package:flutter/material.dart';

// class ShowView extends StatelessWidget {
//   const ShowView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Date selection
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                   5,
//                   (index) => _buildDateCard(
//                     date: index + 1,
//                     day: _getDayName(index),
//                     isSelected: index == 0,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               'Select Cinema',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Cinema selection
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _buildCinemaCard('Labim Mall', isSelected: true),
//                 _buildCinemaCard('City Center'),
//                 _buildCinemaCard('Civil Mall'),
//               ],
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               'Show Time',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Show time selection
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: [
//                 _buildTimeCard('09:00 AM', isSelected: true),
//                 _buildTimeCard('12:00 PM'),
//                 _buildTimeCard('02:30 PM'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDateCard({
//     required int date,
//     required String day,
//     bool isSelected = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF3A3F47) : Colors.transparent,
//         border: Border.all(
//           color: isSelected ? Colors.transparent : Colors.grey,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             date.toString(),
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             day,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCinemaCard(String name, {bool isSelected = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF3A3F47) : Colors.transparent,
//         border: Border.all(
//           color: isSelected ? Colors.transparent : Colors.grey,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         name,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.grey,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }

//   Widget _buildTimeCard(String time, {bool isSelected = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: isSelected ? const Color(0xFF3A3F47) : Colors.transparent,
//         border: Border.all(
//           color: isSelected ? Colors.transparent : Colors.grey,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         time,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.grey,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }

//   String _getDayName(int index) {
//     final days = ['SUN', 'MON', 'TUE', 'WED', 'THU'];
//     return days[index];
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

class ShowView extends StatefulWidget {
  const ShowView({super.key});

  @override
  State<ShowView> createState() => _ShowViewState();
}

class _ShowViewState extends State<ShowView> {
  @override
  void initState() {
    super.initState();
    context.read<ShowBloc>().add(LoadShows()); // ✅ Fetch showtime details
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowBloc, ShowState>(
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
                // 🎬 Display Available Dates Dynamically
                _buildDateSelection(state.shows),
                const SizedBox(height: 24),

                // 🎭 Available Cinemas Section
                const Text(
                  'Select Cinema',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: state.shows
                      .map((show) => _buildCinemaCard(show.hall.hall_name))
                      .toSet()
                      .toList(), // Remove duplicates
                ),
                const SizedBox(height: 24),

                // ⏰ Available Showtimes Section
                const Text(
                  'Show Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: state.shows
                      .map((show) => _buildTimeCard(
                          "${show.start_time} - ${show.end_time}"))
                      .toList(),
                ),

                const SizedBox(height: 24),
                // 🎥 List of Available Movies for Selection
                const Text(
                  'Available Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: state.shows
                        .map((show) => _buildMovieCard(show))
                        .toSet()
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 📅 Build Dynamic Date Selection
  Widget _buildDateSelection(List<ShowEntity> shows) {
    List<String> uniqueDates = shows.map((show) => show.date).toSet().toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: uniqueDates.map((date) {
          return _buildDateCard(
            date: date.split('-')[2], // Extract only the day part
            fullDate: date,
            isSelected: uniqueDates.first == date, // Default first selection
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateCard({
    required String date,
    required String fullDate,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            fullDate,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// 🎭 Build Cinema Card
  Widget _buildCinemaCard(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  /// ⏰ Build Showtime Card
  Widget _buildTimeCard(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  /// 🎥 Build Movie Card for Available Movies
  Widget _buildMovieCard(ShowEntity show) {
    return GestureDetector(
      onTap: () {
        // Handle movie selection for booking
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Movie Poster Image
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_getImageUrl(show.movie.movie_image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Gradient Overlay for Readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ),

              // Movie Name
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8), // Dark gradient
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        show.movie.movie_name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📷 Utility function to get movie image
  String _getImageUrl(String? imagePath) {
    const String baseUrl = "http://10.0.2.2:4011/public/uploads/images/";
    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}
