import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  final UserSignIn _userSignIn;
  final UserSignOut _userSignOut;
  AuthBloc({required UserSignIn userSignIn, required UserSignOut userSignOut})
      : _userSignIn = userSignIn,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoadingState());
      final response = await _userSignIn(NoParams());
      print(response);

      response.fold(
          (failure) => emit(AuthFailureState(message: failure.message)),
          (uid) => emit(AuthSuccessState(userId: uid)));
    });

    on<AuthChanges>((event, emit) async {
      //if user logs out emit AuthInitial state
    });

    on<AuthCheck>((event, emit) {
      //Check if user is logged In
    });

    on<AuthSignOut>((event, emit) async {
      emit(AuthLoadingState());
      final response = await _userSignOut(NoParams());

      response.fold(
          (failure) => emit(AuthFailureState(message: failure.message)),
          (val) => emit(AuthInitial()));
    });
  }
}
