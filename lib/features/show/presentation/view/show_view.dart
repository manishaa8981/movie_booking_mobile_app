import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/show/domain/entity/show_entity.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';

class ShowView extends StatefulWidget {
  const ShowView({super.key});

  @override
  _ShowViewState createState() => _ShowViewState();
}

class _ShowViewState extends State<ShowView> {
  @override
  void initState() {
    super.initState();
    // Load shows when screen loads
    BlocProvider.of<ShowBloc>(context).add(LoadShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Showtimes"),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Failed to load showtimes!",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  SizedBox(height: 5),
                  Text(state.error!, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ShowBloc>(context).add(LoadShows());
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (state.shows.isEmpty) {
            return Center(
              child: Text(
                "No showtimes available.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.shows.length,
            itemBuilder: (context, index) {
              final show = state.shows[index];
              return ShowCard(show: show);
            },
          );
        },
      ),
    );
  }
}

class ShowCard extends StatelessWidget {
  final ShowEntity show;

  const ShowCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          show.movie.movie_name,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text("Hall: ${show.hall.hall_name}",
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5),
            Text(
              "Time: ${show.start_time} - ${show.end_time}",
              style: TextStyle(color: Colors.greenAccent),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54),
        onTap: () {
          // Navigate to seat selection or details page
// Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MovieDetailView(movie: movie),
//             ),
          // );
        },
      ),
    );
  }
}
