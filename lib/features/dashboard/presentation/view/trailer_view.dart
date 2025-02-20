import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

class TrailerView extends StatefulWidget {
  final MovieEntity movie;

  const TrailerView({super.key, required this.movie});

  @override
  State<TrailerView> createState() => _TrailerViewState();
}

class _TrailerViewState extends State<TrailerView> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.movie.trailer_url != null && widget.movie.trailer_url!.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.movie.trailer_url!)
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
          _controller.play();
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.movie.movie_name),
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
