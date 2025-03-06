import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view/show_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailView extends StatefulWidget {
  final MovieEntity movie;

  const MovieDetailView({super.key, required this.movie});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  bool _isPlayingTrailer = false;
  YoutubePlayerController? _youtubeController;

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  void _initializeTrailer() {
    final trailerUrl = widget.movie.trailer_url;

    if (trailerUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Trailer is not available for this movie')),
      );
      return;
    }

    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);

    if (videoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
      return;
    }

    setState(() {
      _isPlayingTrailer = true;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
    });
  }

  void _closeTrailer() {
    setState(() {
      _isPlayingTrailer = false;
      _youtubeController?.dispose();
      _youtubeController = null;
    });

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height * 0.42;

    return WillPopScope(
      onWillPop: () async {
        if (_isPlayingTrailer) {
          _closeTrailer();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.white), // Back Button White
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Details Screen'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                // Movie Poster
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          _getImageUrl(widget.movie.movie_image),
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Play Trailer Button
                      Center(
                        child: GestureDetector(
                          onTap: _initializeTrailer,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Movie Details
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

                          // Movie Title
                          Text(
                            widget.movie.movie_name,
                            style: theme.textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 16),

                          // Description
                          Text(
                            widget.movie.description ??
                                'No description available.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),

                          // Cast
                          const Text('Cast',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            widget.movie.cast_name ??
                                'No cast information available.',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),

                // Book Tickets Button
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: theme.scaffoldBackgroundColor,
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShowView()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Book Tickets',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // YouTube Player Overlay with Improved Close Button Position
            if (_isPlayingTrailer && _youtubeController != null)
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Center(
                        child: YoutubePlayer(controller: _youtubeController!),
                      ),
                      Positioned(
                        top: 40, // Shifted Down for Better Visibility
                        right: 20,
                        child: IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white,
                              size: 32), // White Close Icon
                          onPressed: _closeTrailer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(text, style: theme.textTheme.bodySmall),
    );
  }

  Widget _buildTimeTag(String time) {
    return _buildTag(time);
  }

  String _getImageUrl(String? imagePath) {
    const String baseUrl = "http://192.168.137.1:4011/public/uploads/images/";
    return imagePath != null
        ? "$baseUrl$imagePath"
        : "https://via.placeholder.com/160x200?text=No+Image";
  }
}
