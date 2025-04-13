import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class AddGroupHabitsUseCase implements UseCase<void, AddGroupHabitsParams> {
  final HabitRepository repository;

  AddGroupHabitsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(AddGroupHabitsParams params) {
    return repository.addHabitsFromGroup(params.habits, params.userId);
  }
}

class AddGroupHabitsParams {
  final List<Habit> habits;
  final String userId;

  AddGroupHabitsParams({required this.habits, required this.userId});
}
