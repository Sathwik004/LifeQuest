import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lifequest/features/auth/data/repos/auth_repo_imp.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_out.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  await _authdependencies();
  await _homeDependencies();
}

Future<void> _authdependencies() async {
  serviceLocater.registerLazySingleton(
    () => GoogleSignIn(),
  );

  serviceLocater.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory<AuthRepo>(
    () => AuthRepoImp(
      authRemoteDataSource: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => UserSignIn(
      authRepo: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => UserSignOut(
      authRepo: serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton<AuthBloc>(
    () => AuthBloc(userSignIn: serviceLocater(), userSignOut: serviceLocater()),
  );
}

Future<void> _homeDependencies() async {
  // Add your home dependencies here
  serviceLocater.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  serviceLocater.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}
