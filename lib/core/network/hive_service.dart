import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService{
  Future<void> init() async{
    var directory = await getApplicationCacheDirectory();
    var path = '${directory.path}movie_ticket_booking.db';
    
    Hive.init(path);
    

  }
}