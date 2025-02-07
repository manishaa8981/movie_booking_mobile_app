import 'package:dio/dio.dart';
import 'package:movie_ticket_booking/app/constants/api_endpoints.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/movie_data_source.dart';
import 'package:movie_ticket_booking/features/dashboard/data/dto/get_all_movie_dto.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_api_model.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/entity/movie_entity.dart';

class MovieRemoteDatasource implements IMovieDataSource {
  final Dio _dio;

  MovieRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllMovies);
      if (response.statusCode == 200) {
        GetAllMovieDTO movieDTO = GetAllMovieDTO.fromJson(response.data);
        return MovieApiModel.toEntityList(movieDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

 @override
  Future<MovieEntity> getMovieDetails(String movieId) async {
    try {
      var response = await _dio.get("${ApiEndpoints.getMovieDetails}/$movieId");
      if (response.statusCode == 200) {
        MovieApiModel movieApiModel = MovieApiModel.fromJson(response.data);
        return movieApiModel.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
