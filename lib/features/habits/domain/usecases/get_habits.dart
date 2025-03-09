import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class GetHabitsUseCase implements UseCase<List<Habit>, GetHabitParams> {
  final HabitRepository repository;

  GetHabitsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Habit>>> call(GetHabitParams params) {
    return repository.getHabits(params.userId);
  }
}

class GetHabitParams {
  final String userId;

  GetHabitParams({required this.userId});
}
