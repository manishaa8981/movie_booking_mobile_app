import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/local_datasource/movie_local_datasource.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/remote_datasource/movie_remote_datasource.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_hive_model.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/repository/movie_repository.dart';

class MovieConnectivityRepository implements IMovieRepository {
  final MovieRemoteDatasource _remoteDatasource;
  final MovieLocalDatasource _localDatasource;
  final HiveService _hiveService;
  final Connectivity _connectivity;

  MovieConnectivityRepository({
    required MovieRemoteDatasource remoteDatasource,
    required MovieLocalDatasource localDatasource,
    required HiveService hiveService,
    required Connectivity connectivity,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource,
        _hiveService = hiveService,
        _connectivity = connectivity;

  @override
  Future<Either<Failure, List<MovieEntity>>> getAllMovies() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    // Check if there's internet connection
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Fetch movies from remote source
        final movies = await _remoteDatasource.getAllMovies();
        
        // Convert and save to local Hive database
        final hiveMovies = movies.map((movie) => 
          MovieHiveModel(
            movieId: movie.movieId ?? '',
            movie_name: movie.movie_name,
            movie_image: movie.movie_image,
            genre: movie.genre,
            language: movie.language,
            duration: movie.duration,
            description: movie.description,
            release_date: movie.release_date,
            cast_name: movie.cast_name,
            cast_image: movie.cast_image,
            rating: movie.rating,
            status: movie.status,
            trailer_url: movie.trailer_url,
          )
        ).toList();

        // Save to local storage
        await _hiveService.saveMovies(hiveMovies);

        return Right(movies);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      // No internet, fetch from local storage
      try {
        final localMovies = await _localDatasource.getAllMovies();
        return Right(localMovies);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: 'Error fetching local movies: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetails(String movieId) async {
    var connectivityResult = await _connectivity.checkConnectivity();

    // Check if there's internet connection
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // Fetch movie details from remote source
        final movie = await _remoteDatasource.getMovieDetails(movieId);
        
        // Convert and save to local Hive database
        final hiveMovie = MovieHiveModel(
          movieId: movie.movieId ?? '',
          movie_name: movie.movie_name,
          movie_image: movie.movie_image,
          genre: movie.genre,
          language: movie.language,
          duration: movie.duration,
          description: movie.description,
          release_date: movie.release_date,
          cast_name: movie.cast_name,
          cast_image: movie.cast_image,
          rating: movie.rating,
          status: movie.status,
          trailer_url: movie.trailer_url,
        );

        // Save to local storage
        await _hiveService.get(hiveMovie);

        return Right(movie);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      // No internet, fetch from local storage
      try {
        final localMovie = await _localDatasource.getMovieDetails(movieId);
        return Right(localMovie);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: 'Error fetching local movie details: $e'));
      }
    }
  }
}