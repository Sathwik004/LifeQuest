import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';

abstract interface class GroupRepository {
  Future<Either<Failure, void>> createGroup(Groups group);
  Future<Either<Failure, void>> joinGroup(String groupId, String userId);
  Future<Either<Failure, void>> leaveGroup(String groupId, String userId);
  Future<Either<Failure, List<Groups>>> getGroupsForUser(String userId);
  Future<Either<Failure, List<Groups>>> discoverGroups({int limit});
}
