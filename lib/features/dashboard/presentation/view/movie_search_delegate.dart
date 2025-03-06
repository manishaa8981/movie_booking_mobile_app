import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view/movie_detail_view.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search text
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close search view
      },
    );
  }
  

  @override
  Widget buildResults(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    final List<MovieEntity> movieList = movieBloc.state.movies;

    final searchResults = movieList
        .where((movie) =>
            movie.movie_name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return const Center(child: Text("No movies found"));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return ListTile(
          title: Text(movie.movie_name),
          leading: Image.network(
            "http://192.168.137.1:4011/public/uploads/images/${movie.movie_image}",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailView(movie: movie),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    final List<MovieEntity> movieList = movieBloc.state.movies;

    print("Total movies available: ${movieList.length}"); // Debugging

    final searchResults = movieList
        .where((movie) =>
            movie.movie_name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    print("Search results found: ${searchResults.length}"); // Debugging

    return searchResults.isEmpty
        ? const Center(child: Text("No movies found"))
        : ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final movie = searchResults[index];
              return ListTile(
                title: Text(movie.movie_name),
                leading: Image.network(
                  "http://192.168.137.1:4011/public/uploads/images/${movie.movie_image}",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailView(movie: movie),
                    ),
                  );
                },
              );
            },
          );
  }
}
