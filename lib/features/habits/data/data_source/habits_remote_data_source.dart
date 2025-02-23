import 'package:lifequest/features/habits/data/models/habit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HabitRemoteDataSource {
  Future<void> addHabit(HabitModel habit);
  Future<void> removeHabit(String id);
  Future<void> updateHabit(HabitModel habit);
  Future<List<HabitModel>> getHabits();
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final FirebaseFirestore firestore;
  final String userId;

  HabitRemoteDataSourceImpl({required this.firestore, required this.userId});

  @override
  Future<void> addHabit(HabitModel habit) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(habit.id)
        .set(habit.toMap());
  }

  @override
  Future<void> removeHabit(String id) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(id)
        .delete();
  }

  @override
  Future<void> updateHabit(HabitModel habit) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(habit.id)
        .update(habit.toMap());
  }

  @override
  Future<List<HabitModel>> getHabits() async {
    print("USER ID ${userId}");
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .get();
    print(querySnapshot.docs.toString());
    return querySnapshot.docs
        .map((doc) => HabitModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
