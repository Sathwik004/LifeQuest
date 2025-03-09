import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class UpdateHabitUseCase implements UseCase<void, HabitParams> {
  final HabitRepository repository;

  UpdateHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(HabitParams params) {
    return repository.updateHabit(params.habit, params.userId);
  }
}

class HabitParams {
  final Habit habit;
  final String userId;

  HabitParams(this.habit, {required this.userId});
}
