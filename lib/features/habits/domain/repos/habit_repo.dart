import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';

abstract class HabitRepository {
  Future<Either<Failure, void>> addHabit(Habit habit, String userId);
  Future<Either<Failure, void>> removeHabit(String habitId, String userId);
  Future<Either<Failure, void>> updateHabit(Habit habit, String userId);
  Future<Either<Failure, List<Habit>>> getHabits(String userId);
}
