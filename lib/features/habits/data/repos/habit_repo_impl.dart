import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';
import 'package:lifequest/features/habits/data/data_source/habits_remote_data_source.dart';
import 'package:lifequest/features/habits/data/models/habit_model.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/repos/habit_repo.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource remoteDataSource;

  HabitRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addHabit(Habit habit) async {
    try {
      final habitModel = HabitModel(
        id: habit.id,
        title: habit.title,
        description: habit.description,
        streak: habit.streak,
        lastCompleted: habit.lastCompleted,
        isActive: habit.isActive,
      );
      await remoteDataSource.addHabit(habitModel);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeHabit(String habitId) async {
    try {
      await remoteDataSource.removeHabit(habitId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHabit(Habit habit) async {
    try {
      final habitModel = HabitModel(
        id: habit.id,
        title: habit.title,
        description: habit.description,
        streak: habit.streak,
        lastCompleted: habit.lastCompleted,
        isActive: habit.isActive,
      );
      await remoteDataSource.updateHabit(habitModel);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Habit>>> getHabits() async {
    try {
      final habitModels = await remoteDataSource.getHabits();
      final habits = habitModels
          .map((habitModel) => Habit(
                id: habitModel.id,
                title: habitModel.title,
                description: habitModel.description,
                streak: habitModel.streak,
                lastCompleted: habitModel.lastCompleted,
                isActive: habitModel.isActive,
              ))
          .toList();
      return right(habits);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
