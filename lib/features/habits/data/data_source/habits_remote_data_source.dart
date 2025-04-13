import 'package:lifequest/features/habits/data/models/habit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class HabitRemoteDataSource {
  Future<void> addHabit(HabitModel habit, String userId);
  Future<void> addGroupHabits(List<HabitModel> habits, String userId);
  Future<void> removeHabit(String id, String userId);
  Future<void> removeGroupHabits(String groupId, String userId);
  Future<void> updateHabit(HabitModel habit, String userId);
  Future<List<HabitModel>> getHabits(String userId);
  Future<void> updateStreak(String id, String userId);
}

class HabitRemoteDataSourceImpl implements HabitRemoteDataSource {
  final FirebaseFirestore firestore;

  HabitRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> updateStreak(String habitId, String userId) async {
    // TODO: Add only the new completion date to the habit
  }

  @override
  Future<void> addHabit(HabitModel habit, String userId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(habit.id)
        .set(habit.toMap());
  }

  @override
  Future<void> addGroupHabits(List<HabitModel> habits, String userId) async {
    final batch = firestore.batch();
    final habitCollection =
        firestore.collection('users').doc(userId).collection('habits');

    for (final habit in habits) {
      final docRef = habitCollection.doc(habit.id);
      batch.set(docRef, habit.toMap());
    }

    await batch.commit();
  }

  @override
  Future<void> removeHabit(String id, String userId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(id)
        .delete();
  }

  @override
  Future<void> removeGroupHabits(String groupId, String userId) async {
    final collection =
        firestore.collection('users').doc(userId).collection('habits');

    final querySnapshot =
        await collection.where('groupId', isEqualTo: groupId).get();

    final batch = firestore.batch();

    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  @override
  Future<void> updateHabit(HabitModel habit, String userId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .doc(habit.id)
        .update(habit.toMap());
  }

  @override
  Future<List<HabitModel>> getHabits(String userId) async {
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('habits')
        .get();
    return querySnapshot.docs
        .map((doc) => HabitModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
