import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view/movie_detail_view.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';
import 'package:movie_ticket_booking/utils/gyroscope_tilt_view.dart';
import 'package:movie_ticket_booking/utils/shake_detector.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late ShakeDetector _shakeDetector;

  @override
  void initState() {
    super.initState();

    // ✅ Initialize ShakeDetector for refreshing movies
    _shakeDetector = ShakeDetector(
      onShake: _refreshMovieList,
      shakeThreshold: 2.5,
    );

    _shakeDetector.startListening();

    // ✅ Fetch movies on init
    context.read<MovieBloc>().add(LoadMovies());
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  void _refreshMovieList() {
    debugPrint("🔄 Shake detected! Refreshing Movie List...");
    context.read<MovieBloc>().add(LoadMovies());
  }

  bool isSearchExpanded = false;
  String selectedLocation = 'New York';
  final List<String> locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston'
  ];
  int _currentCarouselIndex = 0;

  // Sample coming soon movies
  final List<MovieEntity> comingSoonMovies = [
    MovieEntity(
      movie_name: 'The Diplomat',
      movie_image: 'image.png',
      release_date: '2025-06-15',
      rating: 'P',
      description: 'ddfddd',
      trailer_url: 'https://youtu.be/hai51TGlYTw?si=qy9DzOebF_7-sKjn',
    ),
    MovieEntity(
      movie_name: 'The Diplomat',
      movie_image: 'image.png',
      release_date: '2025-06-15',
      rating: 'P',
      description: 'ddfddd',
      trailer_url: 'https://youtu.be/hai51TGlYTw?si=qy9DzOebF_7-sKjn',
    ),
  ];

  Widget _buildFeaturedCarousel(List<MovieEntity> movies) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          _getImageUrl(movie.movie_image),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.movie_name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to booking page
                                },
                                child: const Text('Book Now'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: movies.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(
                  _currentCarouselIndex == entry.key ? 0.9 : 0.4,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMovieCard(MovieEntity movie, {bool isComingSoon = false}) {
    return GestureDetector(
      onTap: () {
        if (!isComingSoon) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailView(movie: movie),
            ),
          );
        } else {
          _showComingSoonDetails(movie);
        }
      },
      child: GyroscopeTiltView(
        onNavigate: () {
          if (!isComingSoon) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailView(movie: movie),
              ),
            );
          } else {
            _showComingSoonDetails(movie);
          }
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
                // Movie poster image
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_getImageUrl(movie.movie_image)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Gradient overlay for better text visibility
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

                // Coming soon tag if applicable
                if (isComingSoon)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'COMING SOON',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),

                // Movie title at bottom
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
                          Colors.black.withOpacity(
                              0.8), // Dark gradient for readability
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Name
                        Text(
                          movie.movie_name,
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

                        const SizedBox(
                            height: 4), // Space between name & rating

                        // Rating Row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.orangeAccent),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating ?? "N/A", // ✅ Show "N/A" if null
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoonDetails(MovieEntity movie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(_getImageUrl(movie.movie_image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.movie_name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Release Date: ${movie.release_date}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Description: ${movie.description}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageUrl(String? imagePath) {
    // const String baseUrl = "http://10.0.2.2:4011/public/uploads/images/";
    const String baseUrl = "http://192.168.137.1:4011/public/uploads/images/";

    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.movies.isNotEmpty) ...[
                _buildFeaturedCarousel(state.movies.take(5).toList()),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Now Showing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return _buildMovieCard(state.movies[index]);
                    },
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: comingSoonMovies.length,
                  itemBuilder: (context, index) {
                    return _buildMovieCard(
                      comingSoonMovies[index],
                      isComingSoon: true,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
