part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;
  const UserLoaded(this.user);
}

class UserNotRegistered extends UserState {}

class UserError extends UserState {
  final String message;
  const UserError(this.message);
}
