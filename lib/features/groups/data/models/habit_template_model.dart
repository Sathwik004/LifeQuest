import 'package:lifequest/features/groups/domain/entities/habit_template.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class HabitTemplateModel {
  final String title;
  final String description;
  final String frequency;
  final String difficulty;

  HabitTemplateModel({
    required this.title,
    required this.description,
    required this.frequency,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'frequency': frequency,
        'difficulty': difficulty,
      };

  factory HabitTemplateModel.fromMap(Map<String, dynamic> map) {
    return HabitTemplateModel(
      title: map['title'],
      description: map['description'],
      frequency: map['frequency'],
      difficulty: map['difficulty'],
    );
  }

  HabitTemplate toEntity() => HabitTemplate(
        title: title,
        description: description,
        frequency: HabitFrequency.values.byName(frequency),
        difficulty: HabitDifficulty.values.byName(difficulty),
      );

  static HabitTemplateModel fromEntity(HabitTemplate habit) =>
      HabitTemplateModel(
        title: habit.title,
        description: habit.description,
        frequency: habit.frequency.name,
        difficulty: habit.difficulty.name,
      );
}
