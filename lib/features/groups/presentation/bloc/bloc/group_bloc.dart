import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/domain/usecases/create_group.dart';
import 'package:lifequest/features/groups/domain/usecases/discover_group.dart';
import 'package:lifequest/features/groups/domain/usecases/get_groups.dart';
import 'package:lifequest/features/groups/domain/usecases/join_group.dart';
import 'package:lifequest/features/groups/domain/usecases/leave_group.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final CreateGroup createGroup;
  final JoinGroup joinGroup;
  final LeaveGroup leaveGroup;
  final GetGroupsForUser getGroupsForUser;
  final DiscoverGroups discoverGroups;

  GroupBloc({
    required this.createGroup,
    required this.joinGroup,
    required this.leaveGroup,
    required this.getGroupsForUser,
    required this.discoverGroups,
  }) : super(GroupInitial()) {
    on<CreateGroupEvent>(_onCreateGroup);
    on<JoinGroupEvent>(_onJoinGroup);
    on<LeaveGroupEvent>(_onLeaveGroup);
    on<GetGroupsForUserEvent>(_onGetGroupsForUser);
    on<DiscoverGroupsEvent>(_onDiscoverGroups);
  }

  Future<void> _onCreateGroup(
      CreateGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    final result = await createGroup(event.group);
    result.fold(
      (failure) => emit(GroupError(failure.message)),
      (_) => add(GetGroupsForUserEvent(userId: event.group.creatorId)),
    );
  }

  Future<void> _onJoinGroup(
      JoinGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    final result =
        await joinGroup(JoinGroupParams(event.groupId, event.userId));
    result.fold(
      (failure) => emit(GroupError(failure.message)),
      (_) => add(GetGroupsForUserEvent(userId: event.userId)),
    );
  }

  Future<void> _onLeaveGroup(
      LeaveGroupEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    final result =
        await leaveGroup(LeaveGroupParams(event.groupId, event.userId));
    result.fold(
      (failure) => emit(GroupError(failure.message)),
      (_) => add(GetGroupsForUserEvent(userId: event.userId)),
    );
  }

  Future<void> _onGetGroupsForUser(
      GetGroupsForUserEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    final result = await getGroupsForUser(event.userId);
    result.fold(
      (failure) => emit(GroupError(failure.message)),
      (groups) => groups.isEmpty
          ? emit(GroupEmpty())
          : emit(GroupOperationSuccess(groups)),
    );
  }

  Future<void> _onDiscoverGroups(
      DiscoverGroupsEvent event, Emitter<GroupState> emit) async {
    emit(GroupLoading());
    final result = await discoverGroups(event.limit);
    result.fold(
      (failure) => emit(GroupError(failure.message)),
      (groups) => groups.isEmpty
          ? emit(GroupEmpty())
          : emit(GroupOperationSuccess(groups)),
    );
  }
}


// TODO: Add all dependencies to initdependencies.dart file
// TODO: Add appropriate bloc provider in main.dart file
// TODO: Add bloc listeners or builders 