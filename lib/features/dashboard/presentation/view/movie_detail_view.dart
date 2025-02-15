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
    const String baseUrl = "http://10.0.2.2:4011/public/uploads/images/";
    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}

// import 'package:flutter/material.dart';
// import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

// class MovieDetailView extends StatefulWidget {
//   final MovieEntity movie;

//   const MovieDetailView({super.key, required this.movie});

//   @override
//   State<MovieDetailView> createState() => _MovieDetailViewState();
// }

// class _MovieDetailViewState extends State<MovieDetailView> {
//   bool showDetails = true;
//   final spotifyBlack = const Color(0xFF121212);
//   final spotifyGreen = const Color(0xFF1DB954);

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: spotifyBlack,
//       body: Stack(
//         children: [
//           // Backdrop Image with Gradient Overlay
//           ShaderMask(
//             shaderCallback: (rect) {
//               return LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.black, Colors.transparent],
//               ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
//             },
//             blendMode: BlendMode.dstIn,
//             child: Image.network(
//               _getImageUrl(widget.movie.movie_image),
//               height: screenSize.height * 0.6,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Top Bar
//                 SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios,
//                               color: Colors.white),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                         IconButton(
//                           icon:
//                               const Icon(Icons.more_vert, color: Colors.white),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Main Content
//                 Container(
//                   margin: EdgeInsets.only(top: screenSize.height * 0.35),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [Colors.transparent, spotifyBlack],
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Movie Title and Rating
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.movie.movie_name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Icon(Icons.star, color: spotifyGreen, size: 20),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   '${widget.movie.rating}/10',
//                                   style: TextStyle(
//                                     color: Colors.grey[300],
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Quick Info Pills
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           children: [
//                             if (widget.movie.genre != null)
//                               _buildPill(widget.movie.genre!),
//                             if (widget.movie.language != null)
//                               _buildPill(widget.movie.language!),
//                             if (widget.movie.duration != null)
//                               _buildPill(widget.movie.duration!),
//                             _buildPill(widget.movie.rating != null
//                                 ? '${widget.movie.rating}+'
//                                 : 'Not Rated'),
//                           ],
//                         ),
//                       ),

//                       // Book Tickets Button
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: spotifyGreen,
//                             minimumSize: const Size(double.infinity, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                           child: const Text(
//                             'BOOK TICKETS',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                         ),
//                       ),

//                       // Cast Section
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Cast & Crew',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   // Example cast members - replace with actual data
//                                   _buildCastMember('Actor 1', 'Lead Role'),
//                                   _buildCastMember('Actor 2', 'Supporting'),
//                                   _buildCastMember('Actor 3', 'Supporting'),
//                                   _buildCastMember('Director', 'Director'),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Synopsis
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Synopsis',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               widget.movie.description ??
//                                   'No description available.',
//                               style: TextStyle(
//                                 color: Colors.grey[300],
//                                 fontSize: 16,
//                                 height: 1.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Additional Info
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildInfoRow('Release Date', '2024'),
//                             _buildInfoRow('Director', 'Director Name'),
//                             _buildInfoRow('Writers', 'Writer 1, Writer 2'),
//                             _buildInfoRow('Production', 'Studio Name'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPill(String text) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }

//   Widget _buildCastMember(String name, String role) {
//     return Container(
//       margin: const EdgeInsets.only(right: 16),
//       width: 120,
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundColor: Colors.grey[800],
//             child: const Icon(Icons.person, size: 40, color: Colors.white54),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             name,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           Text(
//             role,
//             style: TextStyle(
//               color: Colors.grey[400],
//               fontSize: 12,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey[500],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getImageUrl(String? imagePath) {
//     const String baseUrl = "http://10.0.2.2:4011/public/uploads/images/";
//     return imagePath != null
//         ? "$baseUrl$imagePath"
//         : "https://via.placeholder.com/160x200?text=No+Image";
//   }
// }
