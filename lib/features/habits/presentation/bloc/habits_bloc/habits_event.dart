part of 'habits_bloc.dart';

abstract class HabitsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetHabitsEvent extends HabitsEvent {
  final String userId;

  GetHabitsEvent({required this.userId});
}

class AddHabitsEvent extends HabitsEvent {
  final Habit habits;
  final String userId;

  AddHabitsEvent({required this.habits, required this.userId});

  @override
  List<Object?> get props => [habits];
}

class UpdateHabitsEvent extends HabitsEvent {
  final Habit habits;
  final String userId;

  UpdateHabitsEvent({required this.habits, required this.userId});

  @override
  List<Object?> get props => [habits];
}

class RemoveHabitsEvent extends HabitsEvent {
  final String habitId;
  final String userId;

  RemoveHabitsEvent({required this.habitId, required this.userId});

  @override
  List<Object?> get props => [habitId];
}

class IncrementHabitStreakEvent extends HabitsEvent {
  final String habitId;
  final String userId;

  IncrementHabitStreakEvent(this.habitId, {required this.userId});
}

class HabitsResetEvent extends HabitsEvent {}
