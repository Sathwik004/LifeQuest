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
    return repository.addHabit(params.habit, params.userId);
  }
}

class HabitParams {
  final Habit habit;
  final String userId;

  HabitParams({required this.habit, required this.userId});
}
