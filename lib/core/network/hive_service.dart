import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking/app/constants/hive_table_constant.dart';
import 'package:movie_ticket_booking/features/auth/data/model/auth_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationCacheDirectory();
    var path = '${directory.path}movie_ticket_booking.db';

    Hive.init(path);

    //Register Adapter
    Hive.registerAdapter(AuthHiveModelAdapter());

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

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
    // await Hive.deleteBoxFromDisk(HiveTableConstant.);
    // await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
