import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class RemoveHabitUseCase implements UseCase<void, HabitIdParams> {
  final HabitRepository repository;

  RemoveHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(HabitIdParams params) {
    return repository.removeHabit(params.habitId, params.userId);
  }
}

class HabitIdParams {
  final String habitId;
  final String userId;

  HabitIdParams(this.habitId, {required this.userId});
}
