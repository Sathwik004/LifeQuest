import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/usecases/add_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/get_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/remove_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/update_habit.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final GetHabitsUseCase getHabitsUseCase;
  final AddHabitUseCase addHabitUseCase;
  final UpdateHabitUseCase updateHabitUseCase;
  final RemoveHabitUseCase removeHabitUseCase;

  HabitsBloc({
    required this.getHabitsUseCase,
    required this.addHabitUseCase,
    required this.updateHabitUseCase,
    required this.removeHabitUseCase,
  }) : super(HabitsInitial()) {
    on<GetHabitsEvent>((event, emit) async {
      print("Getting habits\n\n");
      emit(HabitsLoading());
      final result =
          await getHabitsUseCase(GetHabitParams(userId: event.userId));

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (habits) => emit(HabitsLoaded(habits, userId: event.userId)),
      );
    });

    on<AddHabitsEvent>((event, emit) async {
      print("Adding habit\n\n");
      //emit(HabitsLoading());
      final result = await addHabitUseCase(
        AddHabitParams(habit: event.habits, userId: event.userId),
      );

      print("\n\n\n INSIDE BLOC\n\n\n $result");

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;
          print(state);
          if (currentState is HabitsLoaded) {
            final updatedHabits = List<Habit>.from(currentState.habits)
              ..add(event.habits);
            emit(HabitsLoaded(updatedHabits, userId: event.userId));
          } else {
            emit(HabitsErrorState("Failed to add habit"));
          }
        },
      );
    });

    on<UpdateHabitsEvent>((event, emit) async {
      final result = await updateHabitUseCase(
        UpdateHabitParams(habit: event.habit, userId: event.userId),
      );

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;
          if (currentState is HabitsLoaded) {
            final updatedHabits = currentState.habits
                .map(
                    (habit) => habit.id == event.habit.id ? event.habit : habit)
                .toList();
            emit(HabitsLoaded(updatedHabits, userId: event.userId));
          } else {
            emit(HabitsErrorState("Failed to update habit"));
          }
        },
      );
    });

    on<HabitsResetEvent>((event, emit) {
      print("Resetting habits\n\n");
      emit(HabitsInitial());
    });
  }
}
