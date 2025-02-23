import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class GetHabitsUseCase implements UseCase<List<Habit>, NoParams> {
  final HabitRepository repository;

  GetHabitsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Habit>>> call(NoParams params) {
    return repository.getHabits();
  }
}
