import 'package:equatable/equatable.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class HabitTemplate extends Equatable {
  final String title;
  final String description;
  final HabitFrequency frequency;
  final HabitDifficulty difficulty;

  const HabitTemplate({
    required this.title,
    required this.description,
    this.frequency = HabitFrequency.daily,
    this.difficulty = HabitDifficulty.easy,
  });

  @override
  List<Object?> get props => [title, description, frequency, difficulty];
}
