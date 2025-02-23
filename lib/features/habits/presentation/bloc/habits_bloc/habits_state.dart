part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;

  HabitsLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class HabitsErrorState extends HabitsState {
  final String message;

  HabitsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
