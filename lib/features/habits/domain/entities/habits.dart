import 'package:equatable/equatable.dart';
import 'package:lifequest/features/groups/domain/entities/habit_template.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';
import 'package:uuid/uuid.dart';

class Habit extends Equatable {
  final String id;
  final String? groupId;
  final String title;
  final String description;
  final int streak;
  final DateTime lastCompleted;
  final bool isActive;
  final HabitFrequency frequency;
  final HabitDifficulty difficulty;

  const Habit({
    required this.id,
    this.groupId,
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
    String? groupId,
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
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      description: description ?? this.description,
      streak: streak ?? this.streak,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      isActive: isActive ?? this.isActive,
      frequency: frequency ?? this.frequency,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  factory Habit.fromTemplate(
    HabitTemplate template, {
    String? groupId,
  }) {
    return Habit(
      id: const Uuid().v4(),
      groupId: groupId,
      title: template.title,
      description: template.description,
      streak: 0,
      lastCompleted: DateTime(1999, 9, 9),
      isActive: true,
      frequency: template.frequency,
      difficulty: template.difficulty,
    );
  }

  @override
  List<Object?> get props => [
        id,
        groupId,
        title,
        description,
        streak,
        lastCompleted,
        isActive,
        frequency,
        difficulty
      ];
}
