import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_ticket_booking/app/shared_prefs/token_shared_prefs.dart';
import 'package:movie_ticket_booking/core/network/api_service.dart';
import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:movie_ticket_booking/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:movie_ticket_booking/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:movie_ticket_booking/features/auth/data/repository/auth_remote_repository.dart/auth_remote_repository.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/login_usecase.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:movie_ticket_booking/features/dashboard/data/data_source/remote_datasource/movie_remote_datasource.dart';
import 'package:movie_ticket_booking/features/dashboard/data/repository/movie_remote_repository.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_all_movies_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/domain/use_case/get_movie_details_usecase.dart';
import 'package:movie_ticket_booking/features/dashboard/presentation/view_model/movie_bloc.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';
import 'package:movie_ticket_booking/features/show/data/data_source/remote_datasourse/show_remote_datasource.dart';
import 'package:movie_ticket_booking/features/show/data/repository/show_remote_repostory.dart';
import 'package:movie_ticket_booking/features/show/domain/usecase/get_all_show.dart';
import 'package:movie_ticket_booking/features/show/presentation/view-model/show_bloc.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view_model/on_boarding/on_boarding_cubit.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  _initShowDependencies();
  _initMovieDependencies();
  _initHomeDependencies();
  _initRegisterDependencies();
  _initLoginDependencies();
  _initSplashScreenDependencies();
  _initOnboardingScreenDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  //Remote Data Source
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initOnboardingScreenDependencies() {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

/// ====================  Register ===================

_initRegisterDependencies() {
  //DataSource
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(getIt<Dio>()),
  );

  //Repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDatasource>()),
  );

  //UseCase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

// ================================ Home ==========================

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}
// =============================Login ============================

_initLoginDependencies() async {
  //Token Shared Preferences
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  //UseCase
  getIt.registerLazySingleton<LoginUseCase>(() =>
      LoginUseCase(getIt<TokenSharedPrefs>(), getIt<AuthRemoteRepository>()));

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

void _initSplashScreenDependencies() {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

// =============================Movie ============================

void _initMovieDependencies() {
  //DataSource
  getIt.registerLazySingleton<MovieRemoteDatasource>(
    () => MovieRemoteDatasource(dio: getIt<Dio>()),
  );

  //Repository
  getIt.registerLazySingleton<MovieRemoteRepository>(
    () => MovieRemoteRepository(
      getIt<MovieRemoteDatasource>(),
    ),
  );

  //Usecase
  getIt.registerLazySingleton<GetAllMoviesUseCase>(
    () => GetAllMoviesUseCase(
      repository: getIt<MovieRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetMovieDetailsUseCase>(
    () => GetMovieDetailsUseCase(
      getIt<MovieRemoteRepository>(),
    ),
  );

  //Bloc
  getIt.registerFactory<MovieBloc>(
    () => MovieBloc(
      getAllMoviesUseCase: getIt<GetAllMoviesUseCase>(),
      getMovieDetailsUseCase: getIt<GetMovieDetailsUseCase>(),
    ),
  );
}

// =============================Movie ============================

void _initShowDependencies() {
  //DataSource
  getIt.registerLazySingleton<ShowRemoteDatasource>(
    () => ShowRemoteDatasource(dio: getIt<Dio>()),
  );

  //Repository
  getIt.registerLazySingleton<ShowRemoteRepository>(
    () => ShowRemoteRepository(
      getIt<ShowRemoteDatasource>(),
    ),
  );

  //Usecase
  getIt.registerLazySingleton<GetAllShowUseCase>(
    () => GetAllShowUseCase(
      repository: getIt<ShowRemoteRepository>(),
    ),
  );

  //Bloc
  getIt.registerFactory<ShowBloc>(
    () => ShowBloc(
      getAllShowUseCase: getIt<GetAllShowUseCase>(),
    ),
  );
}
