import 'package:equatable/equatable.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final String description;
  final int streak;
  final DateTime lastCompleted;
  final bool isActive;
  final HabitFrequency frequency;
  final HabitDifficulty difficulty;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.streak,
    required this.lastCompleted,
    required this.isActive,
    this.frequency = HabitFrequency.daily,
    this.difficulty = HabitDifficulty.easy,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? streak,
    DateTime? lastCompleted,
    bool? isActive,
    HabitFrequency? frequency,
    HabitDifficulty? difficulty,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      streak: streak ?? this.streak,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      isActive: isActive ?? this.isActive,
      frequency: frequency ?? this.frequency,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        streak,
        lastCompleted,
        isActive,
        frequency,
        difficulty
      ];
}

// TODO: Add a method to create a habit from a template
// TODO: Add a groupId to the habit entity which can be null