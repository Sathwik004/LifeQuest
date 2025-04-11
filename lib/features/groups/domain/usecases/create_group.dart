import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';

class CreateGroup implements UseCase<void, Groups> {
  final GroupRepository repository;

  CreateGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(Groups group) {
    return repository.createGroup(group);
  }
}
