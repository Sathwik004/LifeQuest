part of 'auth_bloc.dart';

abstract class AuthState {
  get userId => null;
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String userId;

  AuthSuccessState({required this.userId});
}

final class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}

final class AuthLoggedOutState extends AuthState {}
