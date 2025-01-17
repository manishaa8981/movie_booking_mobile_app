import 'package:get_it/get_it.dart';
import 'package:movie_ticket_booking/core/network/hive_service.dart';
import 'package:movie_ticket_booking/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:movie_ticket_booking/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/login_usecase.dart';
import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/on_boarding/on_boarding_cubit.dart';
import 'package:movie_ticket_booking/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:movie_ticket_booking/features/home/presentation/view_model/home_cubit.dart';
import 'package:movie_ticket_booking/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  _initHomeDependencies();
  _initRegisterDependencies();
  _initLoginDependencies();
  _initSplashScreenDependencies();
  _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initOnboardingScreenDependencies() {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(registerUseCase: getIt()),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

// void _initRegisterDependencies() {
//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(loginBloc: getIt<LoginBloc>()),
//   );
// }

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

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
