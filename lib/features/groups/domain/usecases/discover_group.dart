import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/groups/domain/repos/group_repo.dart';

class DiscoverGroups implements UseCase<List<Groups>, int> {
  final GroupRepository repository;

  DiscoverGroups(this.repository);

  @override
  Future<Either<Failure, List<Groups>>> call(int limit) {
    return repository.discoverGroups(limit: limit);
  }
}
