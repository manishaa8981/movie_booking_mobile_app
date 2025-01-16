import 'package:flutter/material.dart';

class DashbaordView extends StatefulWidget {
  const DashbaordView({super.key});

  @override
  State<DashbaordView> createState() => _DashbaordViewState();
}

class _DashbaordViewState extends State<DashbaordView> {
  bool isSearchExpanded = false;
  String selectedLocation = 'New York';
  final List<String> locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston'
  ];

  // Sample movie data
  final List<Map<String, String>> featuredMovies = [
    {'title': 'Avatar', 'imageUrl': 'assets/images/two.jpeg'},
    {'title': 'Spider-Man', 'imageUrl': 'assets/images/four.jpeg'},
    {'title': 'The Matrix', 'imageUrl': 'assets/images/one.jpeg'},
  ];

  final List<Map<String, String>> nowShowingMovies = [
    {'title': 'Inception', 'imageUrl': 'assets/images/four.jpeg'},
    {'title': 'The Dark Knight', 'imageUrl': 'assets/images/three.webp'},
    {'title': 'Interstellar', 'imageUrl': 'assets/images/one.jpeg'},
  ];

  final List<Map<String, String>> trendingMovies = [
    {'title': 'Dune', 'imageUrl': 'assets/images/one.jpeg'},
    {'title': 'Batman', 'imageUrl': 'assets/images/two.jpeg'},
    {'title': 'Iron Man', 'imageUrl': 'assets/images/three.webp'},
  ];

  void _navigateToSearch(String query) {
    // Navigate to search page with the query
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Search Results: $query')),
          body: const Center(child: Text('Search Results Page')),
        ),
      ),
    );
  }

  Widget _buildMovieCarousel(List<Map<String, String>> movies) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 140,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(movies[index]['imageUrl'] ??
                          'assets/images/download.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // const SizedBox(height: 8),
                Text(
                  movies[index]['title']!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieSection(String title, List<Map<String, String>> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        _buildMovieCarousel(movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: Search and Location
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: isSearchExpanded
                      ? TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search movies...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: _navigateToSearch,
                  )
                      : const Text(
                    'Threater X',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(isSearchExpanded ? Icons.close : Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearchExpanded = !isSearchExpanded;
                    });
                  },
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.location_on),
                  onSelected: (String value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return locations.map((String location) {
                      return PopupMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),

          // Carousel Section
          _buildMovieSection('Featured Movies', featuredMovies),

          // Movie Sections
          _buildMovieSection('Now Showing', nowShowingMovies),
          _buildMovieSection('Trending Movies', trendingMovies),
        ],
      ),
    );
  }
}
