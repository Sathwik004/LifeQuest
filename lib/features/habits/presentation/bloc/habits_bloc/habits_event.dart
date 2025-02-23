part of 'habits_bloc.dart';

abstract class HabitsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetHabitsEvent extends HabitsEvent {}

class AddHabitsEvent extends HabitsEvent {
  final Habit habits;

  AddHabitsEvent(this.habits);

  @override
  List<Object?> get props => [habits];
}

class UpdateHabitsEvent extends HabitsEvent {
  final Habit habits;

  UpdateHabitsEvent(this.habits);

  @override
  List<Object?> get props => [habits];
}

class RemoveHabitsEvent extends HabitsEvent {
  final String habitsId;

  RemoveHabitsEvent(this.habitsId);

  @override
  List<Object?> get props => [habitsId];
}
