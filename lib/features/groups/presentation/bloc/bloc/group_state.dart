part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupOperationSuccess extends GroupState {
  final List<Groups> groups;
  const GroupOperationSuccess(this.groups);
  @override
  List<Object?> get props => [groups];
}

class GroupEmpty extends GroupState {}

class GroupError extends GroupState {
  final String message;
  const GroupError(this.message);
  @override
  List<Object?> get props => [message];
}
