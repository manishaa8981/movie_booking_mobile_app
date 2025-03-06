import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
import 'package:movie_ticket_booking/core/theme/theme_cubit.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view/movie_search_delegate.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove centerTitle to allow more flexible layout
        leadingWidth: 130, // Adjust as needed
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Theater X',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              mySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movie',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}

// // Custom Search Delegate
// class MovieSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back_ios),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Implement search results based on query
//     return ListView(
//       children: [
//         // Example of search results
//         ListTile(
//           title: Text('Search results for: $query'),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement search suggestions
//     return ListView(
//       children: [
//         // Example of search suggestions
//         ListTile(
//           title: Text('Suggestions for: $query'),
//         ),
//       ],
//     );
//   }
// }
