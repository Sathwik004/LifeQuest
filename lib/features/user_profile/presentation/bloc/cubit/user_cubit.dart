import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';
import 'package:lifequest/features/user_profile/domain/usecases/get_user.dart';
import 'package:lifequest/features/user_profile/domain/usecases/save_user.dart';
import 'package:lifequest/features/user_profile/domain/usecases/user_exists.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUser getUserUseCase;
  final SaveUser saveUserUseCase;
  final UserExists userExistsUseCase;

  UserCubit({
    required this.getUserUseCase,
    required this.saveUserUseCase,
    required this.userExistsUseCase,
  }) : super(UserInitial());

  //TODO: Add experience to firstore on completion of a task
  Future<void> addExperience({int experience = 10}) async {
    print("Adding experience........");
    final currentState = state;
    if (currentState is UserLoaded) {
      final updatedUser = currentState.user.copyWith(
        experience: currentState.user.experience + experience,
      );
      emit(UserLoading());
      print("Updated user: ${updatedUser.experience}");

      // final result = await saveUserUseCase(SaveUserParams(user: updatedUser));

      // result.fold(
      //   (failure) => emit(UserError(failure.message)),
      //   (_) => emit(UserLoaded(updatedUser)),
      // );
      emit(UserLoaded(updatedUser));
      print("Experience added");
    }
  }

  Future<void> checkUser(String userId) async {
    emit(UserLoading());

    final exists = await userExistsUseCase(UserExistsParams(userId: userId));

    exists.fold(
      (failure) => emit(UserError(failure.message)),
      (userExists) async {
        if (userExists) {
          // User exists, fetch and load user data
          final userResult =
              await getUserUseCase(GetUserParams(userId: userId));
          userResult.fold(
            (failure) => emit(UserError(failure.message)),
            (user) => emit(UserLoaded(user)),
          );
        } else {
          // User does not exist, prompt for username
          emit(UserNotRegistered());
        }
      },
    );
  }

  Future<void> registerUser(String userId, String username) async {
    emit(UserLoading());

    final newUser = UserEntity(
      uid: userId,
      username: username,
      level: 1,
    );

    final result = await saveUserUseCase(SaveUserParams(user: newUser));

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (_) => emit(UserLoaded(newUser)),
    );
  }

  void reset() {
    emit(UserInitial());
  }
}
