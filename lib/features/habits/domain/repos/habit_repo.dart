import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';

abstract class HabitRepository {
  Future<Either<Failure, void>> addHabit(Habit habit);
  Future<Either<Failure, void>> removeHabit(String habitId);
  Future<Either<Failure, void>> updateHabit(Habit habit);
  Future<Either<Failure, List<Habit>>> getHabits();
}
