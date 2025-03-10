import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  final String id;
  final String title;
  final String description;
  final int streak;
  final DateTime lastCompleted;
  final bool isActive;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.streak,
    required this.lastCompleted,
    required this.isActive,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    int? streak,
    DateTime? lastCompleted,
    bool? isActive,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      streak: streak ?? this.streak,
      lastCompleted: lastCompleted ?? this.lastCompleted,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, streak, lastCompleted, isActive];
}
