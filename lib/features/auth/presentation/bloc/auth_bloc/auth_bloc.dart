import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/auth/domain/usecases/user_auth_state.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_in.dart';
import 'package:lifequest/features/auth/domain/usecases/user_sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  final UserSignIn _userSignIn;
  final UserSignOut _userSignOut;
  final UserAuthState _userAuthState;
  AuthBloc(
      {required UserSignIn userSignIn,
      required UserSignOut userSignOut,
      required UserAuthState userAuthState})
      : _userSignIn = userSignIn,
        _userSignOut = userSignOut,
        _userAuthState = userAuthState,
        super(AuthInitial()) {
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoadingState());
      final response = await _userSignIn(NoParams());

      response.fold(
          (failure) => emit(AuthFailureState(message: failure.message)),
          (uid) => emit(AuthSuccessState(userId: uid)));
    });

    on<AuthChanges>((event, emit) {
      //if user logs out emit AuthInitial state
    });

    on<AuthCheck>((event, emit) async {
      //Check if user is logged In
      final response = await _userAuthState(NoParams());
      response.fold((failure) => emit(AuthInitial()),
          (uid) => emit(AuthSuccessState(userId: uid)));
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
