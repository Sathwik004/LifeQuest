part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

// Fetch groups the user is part of
class FetchUserGroups extends GroupEvent {
  final String userId;
  const FetchUserGroups({required this.userId});
}

// Join a group
class JoinGroup extends GroupEvent {
  final String userId;
  final String groupId;
  const JoinGroup(this.userId, this.groupId);
}

// Leave a group
class LeaveGroup extends GroupEvent {
  final String userId;
  final String groupId;
  const LeaveGroup(this.userId, this.groupId);
}
