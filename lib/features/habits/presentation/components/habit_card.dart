import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/utils/same_date.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:lifequest/features/habits/presentation/components/edit_habit.dart';
import 'package:lifequest/features/user_profile/presentation/bloc/cubit/user_cubit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        title: Text(
          habit.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/purple-flame2.png"),
              height: 40,
              width: 40,
            ),
            Text(
              habit.streak.toString(),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        subtitle: Text(
          habit.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: habit.groupId != null
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "You can't edit group habits because it is shared"),
                  ),
                );
              }
            : () {
                showDialog(
                  context: context,
                  builder: (_) => EditHabitDialog(
                    habit: habit,
                    onSave: (updatedHabit) {
                      final state = context.read<AuthBloc>().state;

                      if (state is AuthSuccessState) {
                        context.read<HabitsBloc>().add(UpdateHabitsEvent(
                            habit: updatedHabit, userId: state.userId));
                      }
                    },
                    onDelete: () {
                      final state = context.read<AuthBloc>().state;

                      if (state is AuthSuccessState) {
                        context.read<HabitsBloc>().add(RemoveHabitsEvent(
                            habitId: habit.id, userId: state.userId));
                      }
                    },
                  ),
                );
              },
        trailing: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.end,
          spacing: 2,
          children: [
            Checkbox(
              value: isSameDate(habit.lastCompleted, habit.frequency),
              onChanged: isSameDate(habit.lastCompleted, habit.frequency)
                  ? null
                  : (value) {
                      if (value == true) {
                        final state = context.read<AuthBloc>().state;
                        if (state is AuthSuccessState) {
                          context.read<HabitsBloc>().add(UpdateHabitsEvent(
                              habit: habit.copyWith(
                                  streak: habit.streak + 1,
                                  lastCompleted: DateTime.now()),
                              userId: state.userId));

                          context.read<UserCubit>().addExperience(
                                experience: habit.difficulty ==
                                        HabitDifficulty.extreme
                                    ? 30
                                    : habit.difficulty == HabitDifficulty.medium
                                        ? 10
                                        : habit.difficulty ==
                                                HabitDifficulty.hard
                                            ? 15
                                            : 5,
                              );
                        }
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
