import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';

class GetGroupsForUser implements UseCase<List<Groups>, String> {
  final GroupRepository repository;

  GetGroupsForUser(this.repository);

  @override
  Future<Either<Failure, List<Groups>>> call(String userId) {
    return repository.getGroupsForUser(userId);
  }
}
