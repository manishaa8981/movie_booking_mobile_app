class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://192.168.137.1:4011/api/";
  // static const String baseUrl = "http://10.0.2.2:4011/api/";

  // ================= Auth Routes =========================
  static const String login = "auth/loginMobile";
  static const String register = "auth/registerMobile";
  static const String getUserById = "customer/";
  static const String registerUser = "customer/save";

  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
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
  static const String getAllShows = "showtime/";
  static String getshowByid = "showtime/movie/:movieId";

  // // ======================== Hall Routes =============================
  static const String getAllHalls = "hall/";

  // // ======================== Seat Routes =============================
  static String getAllSeats(String hallId) {
    return "seat/hall/$hallId"; // Returns a dynamic URL
  }

  // // ======================== Booking Routes =============================
  static const String createBooking = "booking/";
  static const String getBookings = "booking/";
}
