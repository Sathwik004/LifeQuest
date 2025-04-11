import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';

class JoinGroupParams {
  final String groupId;
  final String userId;

  JoinGroupParams(this.groupId, this.userId);
}

class JoinGroup implements UseCase<void, JoinGroupParams> {
  final GroupRepository repository;

  JoinGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinGroupParams params) {
    return repository.joinGroup(params.groupId, params.userId);
  }
}
