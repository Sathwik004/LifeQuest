import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';

class LeaveGroupParams {
  final String groupId;
  final String userId;

  LeaveGroupParams(this.groupId, this.userId);
}

class LeaveGroup implements UseCase<void, LeaveGroupParams> {
  final GroupRepository repository;

  LeaveGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(LeaveGroupParams params) {
    return repository.leaveGroup(params.groupId, params.userId);
  }
}
