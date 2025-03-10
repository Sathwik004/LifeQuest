import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class UpdateHabitUseCase implements UseCase<void, UpdateHabitParams> {
  final HabitRepository repository;

  UpdateHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(UpdateHabitParams params) {
    return repository.updateHabit(params.habit, params.userId);
  }
}

class UpdateHabitParams {
  final Habit habit;
  final String userId;

  UpdateHabitParams({required this.habit, required this.userId});
}
