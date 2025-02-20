import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view/show_view.dart';

class MovieDetailView extends StatefulWidget {
  final MovieEntity movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 7),
      body: Stack(
        children: [
          // Movie Poster
          SizedBox(
            height: screenSize.height * 0.6,
            width: double.infinity,
            child: Image.network(
              _getImageUrl(widget.movie.movie_image),
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top spacing for status bar
                      SizedBox(height: MediaQuery.of(context).padding.top),

                      // Back button and movie title
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              'Details Screen',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Main content with gradient overlay
                      Container(
                        margin: EdgeInsets.only(top: screenSize.height * 0.35),
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            // Movie details content
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 120),
                                  // Tags row
                                  Row(
                                    children: [
                                      if (widget.movie.rating != null)
                                        _buildTag('${widget.movie.rating}+'),
                                      if (widget.movie.genre != null) ...[
                                        const SizedBox(width: 8),
                                        _buildTag(widget.movie.genre!),
                                      ],
                                      if (widget.movie.language != null) ...[
                                        const SizedBox(width: 8),
                                        _buildTag(widget.movie.language!),
                                      ],
                                      if (widget.movie.duration != null) ...[
                                        const SizedBox(width: 8),
                                        _buildTimeTag(widget.movie.duration!),
                                      ],
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                  // Movie title
                                  Text(
                                    widget.movie.movie_name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Description
                                  Text(
                                    widget.movie.description ??
                                        'No description available.',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Cast',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.movie.cast_name ??
                                        'No description available.',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 80), // Extra padding for button
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Fixed Book Tickets button at the bottom
              Container(
                padding: const EdgeInsets.all(16.0),
                color: const Color.fromARGB(255, 0, 0, 7),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowView(),
                          ),
                        );
                        // Navigate to showtime page
                        // Replace with your actual navigation logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Book Tickets',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTimeTag(String time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.access_time, color: Colors.white, size: 16),
        const SizedBox(width: 4),
        Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getImageUrl(String? imagePath) {
    // const String baseUrl = "http://10.0.2.2:4011/public/uploads/images/";
    const String baseUrl = "http://192.168.137.1:4011/public/uploads/images/";

    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}
