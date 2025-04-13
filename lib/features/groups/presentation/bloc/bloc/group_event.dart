part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class CreateGroupEvent extends GroupEvent {
  final Groups group;
  const CreateGroupEvent(this.group);
  @override
  List<Object?> get props => [];
}

class JoinGroupEvent extends GroupEvent {
  final String groupId;
  final String userId;
  const JoinGroupEvent({required this.groupId, required this.userId});
  @override
  List<Object?> get props => [groupId, userId];
}

class LeaveGroupEvent extends GroupEvent {
  final String groupId;
  final String userId;
  const LeaveGroupEvent({required this.groupId, required this.userId});
  @override
  List<Object?> get props => [groupId, userId];
}

class GetGroupsForUserEvent extends GroupEvent {
  final String userId;
  const GetGroupsForUserEvent({required this.userId});
  @override
  List<Object?> get props => [userId];
}

// class DiscoverGroupsEvent extends GroupEvent {
//   final int limit;
//   const DiscoverGroupsEvent({this.limit = 20});
//   @override
//   List<Object?> get props => [limit];
// }
