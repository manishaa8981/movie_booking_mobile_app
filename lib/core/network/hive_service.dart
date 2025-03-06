import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/auth/data/model/auth_hive_model.dart';
import 'package:movie_ticket_booking/features/dashboard/data/model/movie_hive_model.dart';
import 'package:movie_ticket_booking/features/hall/data/model/hall_hive_model.dart';
import 'package:movie_ticket_booking/features/seat/data/model/seat_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationCacheDirectory();
    var path = '${directory.path}movie_ticket_booking.db';

    Hive.init(path);

    //Register Adapter
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(MovieHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.put(user.authId, user);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    // var auth = box.values.firstWhere(
    //     (element) =>
    //         element.username == username && element.password == password,
    //     orElse: () => AuthHiveModel.initial());
    // return auth;

    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> get(MovieHiveModel movie) async {
    var box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    await box.put(movie.movieId, movie);
  }

  Future<List<MovieHiveModel>> getAllMovies() async {
    var box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    return box.values.toList()
      ..sort((a, b) => a.movie_name.compareTo(b.movie_name));
  }

  Future<List<HallHiveModel>> getAllHalls() async {
    var box = await Hive.openBox<HallHiveModel>(HiveTableConstant.hallBox);
    return box.values.toList()
      ..sort((a, b) => a.hall_name.compareTo(b.hall_name));
  }

  Future<List<SeatHiveModel>> getAllSeats() async {
    var box = await Hive.openBox<SeatHiveModel>(HiveTableConstant.seatBox);
    return box.values.toList()..sort((a, b) => a.seatId.compareTo(b.seatId));
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.movieBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.hallBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.bookingBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  getMovieDetails(String movieId) {}

  // New method to save multiple movies
  Future<void> saveMovies(List<MovieHiveModel> movies) async {
    var box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);

    // Save each movie with its movieId as the key
    for (var movie in movies) {
      await box.put(movie.movieId, movie);
    }

    await box.close();
  }

  // Method to get a specific movie by ID
  Future<MovieHiveModel?> getMovieById(String movieId) async {
    var box = await Hive.openBox<MovieHiveModel>(HiveTableConstant.movieBox);
    var movie = box.get(movieId);
    await box.close();
    return movie;
  }
}
