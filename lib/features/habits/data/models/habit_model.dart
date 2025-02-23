import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.title,
    required super.description,
    required super.streak,
    required super.lastCompleted,
    required super.isActive,
  });

  /// Converts Firestore document data into a `HabitModel`
  factory HabitModel.fromMap(String id, Map<String, dynamic> map) {
    print(map);
    return HabitModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      streak: map['streak'] as int,
      lastCompleted: (map['lastCompleted'] as Timestamp).toDate(),
      isActive: map['isActive'] as bool,
    );
  }

  /// Converts a `HabitModel` into a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'streak': streak,
      'lastCompleted': Timestamp.fromDate(lastCompleted),
      'isActive': isActive,
    };
  }
}
