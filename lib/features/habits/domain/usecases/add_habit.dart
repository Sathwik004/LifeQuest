import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class AddHabitUseCase implements UseCase<void, HabitParams> {
  final HabitRepository repository;

  AddHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(HabitParams params) {
    return repository.addHabit(params.habit);
  }
}

class HabitParams {
  final Habit habit;

  HabitParams(this.habit);
}
