import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/groups/data/data_source/groups_remote_data_source.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';
import 'package:lifequest/features/groups/data/models/group_model.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> createGroup(Groups group) async {
    try {
      final model = GroupModel(
        id: group.id,
        name: group.name,
        description: group.description,
        creatorId: group.creatorId,
        memberIds: group.memberIds,
        badgeColor: group.badgeColor,
        createdAt: group.createdAt,
        habits: group.habits,
      );
      await remoteDataSource.createGroup(model);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup(String groupId, String userId) async {
    try {
      await remoteDataSource.joinGroup(groupId, userId);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveGroup(
      String groupId, String userId) async {
    try {
      await remoteDataSource.leaveGroup(groupId, userId);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Groups>>> getGroupsForUser(String userId) async {
    try {
      final models = await remoteDataSource.getGroupsForUser(userId);
      final groups = models
          .map((model) => Groups(
                id: model.id,
                name: model.name,
                description: model.description,
                creatorId: model.creatorId,
                memberIds: model.memberIds,
                badgeColor: model.badgeColor,
                createdAt: model.createdAt,
                habits: model.habits,
              ))
          .toList();
      return right(groups);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Groups>>> discoverGroups({int limit = 20}) async {
    try {
      final models = await remoteDataSource.discoverGroups(limit: limit);
      final groups = models
          .map((model) => Groups(
                id: model.id,
                name: model.name,
                description: model.description,
                creatorId: model.creatorId,
                memberIds: model.memberIds,
                badgeColor: model.badgeColor,
                createdAt: model.createdAt,
                habits: model.habits,
              ))
          .toList();
      return right(groups);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
