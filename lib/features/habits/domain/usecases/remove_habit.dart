import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class RemoveHabitUseCase implements UseCase<void, RemoveHabitParams> {
  final HabitRepository repository;

  RemoveHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(RemoveHabitParams params) {
    return repository.removeHabit(params.habitId, params.userId);
  }
}

class RemoveHabitParams {
  final String habitId;
  final String userId;

  RemoveHabitParams({required this.habitId, required this.userId});
}
