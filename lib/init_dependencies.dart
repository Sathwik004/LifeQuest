import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lifequest/features/auth/data/repo/auth_repo_imp.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';
import 'package:lifequest/features/auth/domain/usecases/user_auth_state.dart';
import 'package:lifequest/features/groups/data/data_source/groups_remote_data_source.dart';
import 'package:lifequest/features/groups/data/repos/group_repo_impl.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';
import 'package:lifequest/features/groups/domain/usecases/create_group.dart';
import 'package:lifequest/features/groups/domain/usecases/discover_group.dart';
import 'package:lifequest/features/groups/domain/usecases/get_groups.dart';
import 'package:lifequest/features/groups/domain/usecases/join_group.dart';
import 'package:lifequest/features/groups/domain/usecases/leave_group.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/habits/domain/usecases/add_group_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/remove_group_habits.dart';
import 'package:lifequest/features/user_profile/data/data_source/user_remote_data_source.dart';
import 'package:lifequest/features/user_profile/data/repo/user_repo_impl.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';
import 'package:lifequest/features/user_profile/domain/usecases/add_experience.dart';
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

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _authdependencies();
  await _homeDependencies();
  await _habitDependencies();
  await _userProfileDependencies();
  await _guildDependencies();
}

Future<void> _userProfileDependencies() async {
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  serviceLocator.registerFactory<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );

  serviceLocator.registerFactory<UserRepository>(
    () => UserRepoImpl(
      userDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserExists(
      userRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => AddExperienceUseCase(
      userRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SaveUser(userRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetUser(userRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => UserCubit(
      getUserUseCase: serviceLocator(),
      saveUserUseCase: serviceLocator(),
      userExistsUseCase: serviceLocator(),
      addExperienceUseCase: serviceLocator(),
    ),
  );
}

Future<void> _habitDependencies() async {
  // Add your habit dependencies here
  serviceLocator.registerFactory<HabitRemoteDataSource>(
    () => HabitRemoteDataSourceImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );

  serviceLocator.registerFactory<HabitRepository>(
    () => HabitRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => AddHabitUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => AddGroupHabitsUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => RemoveHabitUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => RemoveGroupHabitsUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpdateHabitUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetHabitsUseCase(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<HabitsBloc>(
    () => HabitsBloc(
      addHabitUseCase: serviceLocator(),
      removeHabitUseCase: serviceLocator(),
      updateHabitUseCase: serviceLocator(),
      getHabitsUseCase: serviceLocator(),
      addGroupHabitsUseCase: serviceLocator(),
      removeGroupHabitsUseCase: serviceLocator(),
    ),
  );
}

Future<void> _authdependencies() async {
  serviceLocator.registerLazySingleton(
    () => GoogleSignIn(),
  );

  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepoImp(
      authRemoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignIn(
      authRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignOut(
      authRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserAuthState(
      authRepo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignIn: serviceLocator(),
      userSignOut: serviceLocator(),
      userAuthState: serviceLocator(),
    ),
  );
}

Future<void> _homeDependencies() async {
  serviceLocator.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
  serviceLocator.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

Future<void> _guildDependencies() async {
  serviceLocator.registerFactory<GroupRemoteDataSource>(
    () => GroupRemoteDataSourceImpl(FirebaseFirestore.instance),
  );

  serviceLocator.registerFactory<GroupRepository>(
    () => GroupRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => CreateGroup(serviceLocator()));
  serviceLocator.registerFactory(() => JoinGroup(serviceLocator()));
  serviceLocator.registerFactory(() => LeaveGroup(serviceLocator()));
  serviceLocator.registerFactory(() => GetGroupsForUser(serviceLocator()));
  serviceLocator.registerFactory(() => DiscoverGroups(serviceLocator()));

  serviceLocator.registerFactory(() => GroupBloc(
        createGroup: serviceLocator(),
        joinGroup: serviceLocator(),
        leaveGroup: serviceLocator(),
        getGroupsForUser: serviceLocator(),
        discoverGroups: serviceLocator(),
      ));
}
