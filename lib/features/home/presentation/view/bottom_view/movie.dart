import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  const Movie({super.key});

  @override
  State<Movie> createState() => _ReleasedState();
}

class _ReleasedState extends State<Movie> {

  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
