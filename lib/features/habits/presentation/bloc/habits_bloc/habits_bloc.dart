import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lifequest/core/usecase/usecase.dart';
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
      final result = await getHabitsUseCase(NoParams());

      result.fold(
        (failure) => emit(HabitsErrorState(failure.message)),
        (habits) => emit(HabitsLoaded(habits)),
      );
    });

    on<HabitsEvent>((event, emit) {
      print("Inside habits event");
      print(event);
    });
  }
}
