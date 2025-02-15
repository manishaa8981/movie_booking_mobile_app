import 'package:movie_ticket_booking/core/error/failure.dart';
import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/movie_data_source.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_hive_model.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

class MovieLocalDatasource implements IMovieDataSource{

  final HiveService _hiveService;

  MovieLocalDatasource({required HiveService hiveService})
      : _hiveService = hiveService;


  @override
  Future<List<MovieEntity>> getAllMovies() async{
       try {
      final movieHiveModelList = await _hiveService.getAllMovies();
      return MovieHiveModel.toEntityList(movieHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<MovieEntity> getMovieDetails(String movieId) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }
}