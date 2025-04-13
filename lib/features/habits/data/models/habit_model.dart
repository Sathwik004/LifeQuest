import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.title,
    required super.description,
    required super.streak,
    required super.lastCompleted,
    required super.isActive,
    required super.frequency,
    required super.difficulty,
    super.groupId,
  });

  /// Converts Firestore document data into a `HabitModel`
  factory HabitModel.fromMap(String id, Map<String, dynamic> map) {
    HabitFrequency frequency;
    try {
      frequency = HabitFrequency.values.byName(map['frequency'] as String);
    } catch (_) {
      frequency = HabitFrequency.daily;
    }

    HabitDifficulty difficulty;
    try {
      difficulty = HabitDifficulty.values.byName(map['difficulty'] as String);
    } catch (_) {
      difficulty = HabitDifficulty.easy;
    }

    return HabitModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      streak: map['streak'] as int,
      lastCompleted: (map['lastCompleted'] as Timestamp).toDate(),
      isActive: map['isActive'] as bool,
      frequency: frequency,
      difficulty: difficulty,
      groupId: map['groupId'] as String?, // Nullable groupId
    );
  }

  /// Converts a `HabitModel` into a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'streak': streak,
      'lastCompleted': lastCompleted,
      'isActive': isActive,
      'frequency': frequency.name,
      'difficulty': difficulty.name,
      'groupId': groupId, // Nullable groupId
    };
  }
}
