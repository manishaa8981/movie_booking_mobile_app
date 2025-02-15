class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  // static const String baseUrl = "http://192.168.137.1:4011/api/";
  static const String baseUrl = "http://10.0.2.2:4011/api/";

  // ================= Auth Routes =========================
  static const String login = "auth/loginMobile";
  static const String register = "auth/registerMobile";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getAllMovies = "movie/get";
  static const String getMovieDetails = "movie";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  // static const String imageUrl = "http://10.0.2.2:4011/public/uploads/images/";
  static const String imageUrl =
      "http://192.168.137.1:4011/public/uploads/images/";
  static const String uploadImage = "customer/uploadImage";

  // // ======================== Movie Routes =============================
  static const String getAllMovies = "movie/";
  static const String getMovieDetails = "movie/:id";

  // // ======================== Show Routes =============================
  static const String getAllShows = "show/";
  // static const String getshowByid = "show/:id";

  // // ======================== Hall Routes =============================
  static const String getAllHalls = "hall/";

  // // ======================== Seat Routes =============================
  static const String getAllSeats = "seat/";
}
