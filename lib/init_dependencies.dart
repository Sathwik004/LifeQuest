import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lifequest/features/auth/data/repo/auth_repo_imp.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';
import 'package:lifequest/features/auth/domain/usecases/user_auth_state.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/user_profile/data/data_source/user_remote_data_source.dart';
import 'package:lifequest/features/user_profile/data/repo/user_repo_impl.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';
import 'package:lifequest/features/user_profile/domain/usecases/get_user.dart';
import 'package:lifequest/features/user_profile/domain/usecases/save_user.dart';
import 'package:lifequest/features/user_profile/domain/usecases/user_exists.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_out.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/data/data_source/habits_remote_data_source.dart';
import 'package:lifequest/features/habits/data/repos/habit_repo_impl.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';
import 'package:lifequest/features/habits/domain/usecases/add_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/get_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/remove_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/update_habit.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';
import 'package:lifequest/features/user_profile/presentation/bloc/cubit/user_cubit.dart';

import 'features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  await _authdependencies();
  await _homeDependencies();
  await _habitDependencies();
  await _userProfileDependencies();
  await _guildDependencies();
}

Future<void> _userProfileDependencies() async {
  // Add your user profile dependencies here
  serviceLocater.registerLazySingleton(() => FirebaseFirestore.instance);

  serviceLocater.registerFactory<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );

  serviceLocater.registerFactory<UserRepository>(
    () => UserRepoImpl(
      userDataSource: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => UserExists(
      userRepository: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => SaveUser(userRepository: serviceLocater()),
  );

  serviceLocater.registerFactory(
    () => GetUser(userRepository: serviceLocater()),
  );

  serviceLocater.registerLazySingleton(
    () => UserCubit(
      getUserUseCase: serviceLocater(),
      saveUserUseCase: serviceLocater(),
      userExistsUseCase: serviceLocater(),
    ),
  );
}

Future<void> _habitDependencies() async {
  // Add your habit dependencies here
  serviceLocater.registerFactory<HabitRemoteDataSource>(
    () => HabitRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );

  serviceLocater.registerFactory<HabitRepository>(
    () => HabitRepositoryImpl(
      remoteDataSource: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => AddHabitUseCase(
      repository: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => RemoveHabitUseCase(
      repository: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => UpdateHabitUseCase(
      repository: serviceLocater(),
    ),
  );

  serviceLocater.registerFactory(
    () => GetHabitsUseCase(
      repository: serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton<HabitsBloc>(
    () => HabitsBloc(
      addHabitUseCase: serviceLocater(),
      removeHabitUseCase: serviceLocater(),
      updateHabitUseCase: serviceLocater(),
      getHabitsUseCase: serviceLocater(),
    ),
  );
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

  serviceLocater.registerFactory(
    () => UserAuthState(
      authRepo: serviceLocater(),
    ),
  );

  serviceLocater.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignIn: serviceLocater(),
      userSignOut: serviceLocater(),
      userAuthState: serviceLocater(),
    ),
  );
}

Future<void> _homeDependencies() async {
  // Add your home dependencies here
  serviceLocater.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  serviceLocater.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

Future<void> _guildDependencies() async {
  serviceLocater.registerLazySingleton<GroupBloc>(() => GroupBloc());
}
