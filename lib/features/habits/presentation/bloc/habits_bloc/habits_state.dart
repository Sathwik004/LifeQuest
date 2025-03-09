part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  final String userId;

  HabitsLoaded(this.habits, {required this.userId});

  @override
  List<Object?> get props => [habits];
}

class HabitsErrorState extends HabitsState {
  final String message;

  HabitsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
