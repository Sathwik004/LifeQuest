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

class AddHabitsFromGroupEvent extends HabitsEvent {
  final List<Habit> habits;
  final String userId;

  AddHabitsFromGroupEvent({required this.habits, required this.userId});

  @override
  List<Object?> get props => [habits];
}

class UpdateHabitsEvent extends HabitsEvent {
  final Habit habit;
  final String userId;

  UpdateHabitsEvent({required this.habit, required this.userId});

  @override
  List<Object?> get props => [habit];
}

class RemoveHabitsEvent extends HabitsEvent {
  final String habitId;
  final String userId;

  RemoveHabitsEvent({required this.habitId, required this.userId});

  @override
  List<Object?> get props => [habitId];
}

class RemoveGroupHabitsEvent extends HabitsEvent {
  final String groupId;
  final String userId;

  RemoveGroupHabitsEvent({required this.groupId, required this.userId});

  @override
  List<Object?> get props => [groupId];
}

class IncrementHabitStreakEvent extends HabitsEvent {
  final String habitId;
  final String userId;

  IncrementHabitStreakEvent(this.habitId, {required this.userId});
}

class HabitsResetEvent extends HabitsEvent {}
