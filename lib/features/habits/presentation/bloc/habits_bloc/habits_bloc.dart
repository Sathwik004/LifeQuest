import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/usecases/add_group_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/add_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/get_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/remove_group_habits.dart';
import 'package:lifequest/features/habits/domain/usecases/remove_habit.dart';
import 'package:lifequest/features/habits/domain/usecases/update_habit.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  final GetHabitsUseCase getHabitsUseCase;
  final AddHabitUseCase addHabitUseCase;
  final AddGroupHabitsUseCase addGroupHabitsUseCase;
  final UpdateHabitUseCase updateHabitUseCase;
  final RemoveHabitUseCase removeHabitUseCase;
  final RemoveGroupHabitsUseCase removeGroupHabitsUseCase;

  HabitsBloc({
    required this.getHabitsUseCase,
    required this.addHabitUseCase,
    required this.addGroupHabitsUseCase,
    required this.updateHabitUseCase,
    required this.removeHabitUseCase,
    required this.removeGroupHabitsUseCase,
  }) : super(HabitsInitial()) {
    on<GetHabitsEvent>((event, emit) async {
      emit(HabitsLoading());
      final result =
          await getHabitsUseCase(GetHabitParams(userId: event.userId));

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (habits) => emit(HabitsLoaded(habits, userId: event.userId)),
      );
    });

    on<AddHabitsEvent>((event, emit) async {
      //emit(HabitsLoading());
      final result = await addHabitUseCase(
        AddHabitParams(habit: event.habits, userId: event.userId),
      );

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;
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

    on<AddHabitsFromGroupEvent>((event, emit) async {
      //emit(HabitsLoading());
      final result = await addGroupHabitsUseCase(
        AddGroupHabitsParams(habits: event.habits, userId: event.userId),
      );

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;

          if (currentState is HabitsLoaded) {
            final updatedHabits = List<Habit>.from(currentState.habits)
              ..addAll(event.habits);
            emit(HabitsLoaded(updatedHabits, userId: event.userId));
          } else {
            emit(HabitsErrorState("Failed to add habit $currentState"));
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

    on<RemoveHabitsEvent>((event, emit) async {
      final result = await removeHabitUseCase(
        RemoveHabitParams(habitId: event.habitId, userId: event.userId),
      );

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;
          if (currentState is HabitsLoaded) {
            final updatedHabits = currentState.habits
                .where((habit) => habit.id != event.habitId)
                .toList();
            emit(HabitsLoaded(updatedHabits, userId: event.userId));
          } else {
            emit(HabitsErrorState("Failed to remove habit"));
          }
        },
      );
    });

    on<RemoveGroupHabitsEvent>((event, emit) async {
      final result = await removeGroupHabitsUseCase(
        RemoveGroupHabitsParams(groupId: event.groupId, userId: event.userId),
      );

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (success) {
          final currentState = state;
          if (currentState is HabitsLoaded) {
            final updatedHabits = currentState.habits
                .where((habit) => habit.groupId != event.groupId)
                .toList();
            emit(HabitsLoaded(updatedHabits, userId: event.userId));
          } else {
            emit(HabitsErrorState("Failed to remove group habits"));
          }
        },
      );
    });
    on<HabitsResetEvent>((event, emit) {
      emit(HabitsInitial());
    });
  }
}
