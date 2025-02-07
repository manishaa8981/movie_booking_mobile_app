import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_all_movies_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_movie_details_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetAllMoviesUseCase _getAllMoviesUseCase;
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;

  MovieBloc({
    required GetAllMoviesUseCase getAllMoviesUseCase,
    required GetMovieDetailsUseCase getMovieDetailsUseCase,
  })  : _getAllMoviesUseCase = getAllMoviesUseCase,
        _getMovieDetailsUseCase = getMovieDetailsUseCase,
        super(MovieState.initial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMovieDetails>(_onLoadMovieDetails);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllMoviesUseCase.call();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (movies) => emit(state.copyWith(isLoading: false, error: null)),
    );
  }

  Future<void> _onLoadMovieDetails(
      LoadMovieDetails event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getMovieDetailsUseCase
        .call(event.movieId); // Directly pass movieId

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (movie) => emit(state.copyWith(
        isLoading: false,
        error: null,
      )),
    );
  }
}


//view  ko lagi pxi herna lai 
// class MovieScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Movies')),
//       body: BlocProvider(
//         create: (_) => MovieBloc(
//           getAllMoviesUseCase: GetAllMoviesUseCase(repository: movieRepository),
//           getMovieDetailsUseCase: GetMovieDetailsUseCase(repository: movieRepository),
//         ),
//         child: BlocBuilder<MovieBloc, MovieState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state.error != null) {
//               return Center(child: Text('Error: ${state.error}'));
//             } else {
//               return ListView.builder(
//                 itemCount: state.movies.length,
//                 itemBuilder: (context, index) {
//                   final movie = state.movies[index];
//                   return ListTile(
//                     title: Text(movie.movie_name),
//                     onTap: () {
//                       context.read<MovieBloc>().add(LoadMovieDetails(movieId: movie.movieId));
//                     },
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
