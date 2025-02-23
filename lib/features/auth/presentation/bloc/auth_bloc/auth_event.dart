part of 'auth_bloc.dart';

abstract class AuthBlocEvent {}

final class AuthCheck extends AuthBlocEvent {}

final class AuthSignIn extends AuthBlocEvent {}

final class AuthChanges extends AuthBlocEvent {}

final class AuthSignOut extends AuthBlocEvent {}
