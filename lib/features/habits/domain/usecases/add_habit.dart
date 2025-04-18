import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class AddHabitUseCase implements UseCase<void, AddHabitParams> {
  final HabitRepository repository;

  AddHabitUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(AddHabitParams params) {
    return repository.addHabit(params.habit, params.userId);
  }
}

class AddHabitParams {
  final Habit habit;
  final String userId;

  AddHabitParams({required this.habit, required this.userId});
}
