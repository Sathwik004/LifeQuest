import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class RemoveGroupHabitsUseCase
    implements UseCase<void, RemoveGroupHabitsParams> {
  final HabitRepository repository;

  RemoveGroupHabitsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(RemoveGroupHabitsParams params) {
    return repository.removeGroupHabits(params.groupId, params.userId);
  }
}

class RemoveGroupHabitsParams {
  final String groupId;
  final String userId;

  RemoveGroupHabitsParams({required this.groupId, required this.userId});
}
