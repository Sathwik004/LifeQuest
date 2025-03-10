import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/utils/same_date.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
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
            const Icon(
              Icons.local_fire_department,
              size: 25,
              color: Colors.orange,
            ),
            Text(
              habit.streak.toString(),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        subtitle: Text(
          habit.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onLongPress: () {
          //TODO: Add edit habit functionality
          //TODO: Add delete habit functionality
        },
        trailing: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.end,
          spacing: 2,
          children: [
            IconButton(
                onPressed: isSameDate(habit.lastCompleted)
                    ? null
                    : () {
                        final state = context.read<AuthBloc>().state;
                        if (state is AuthSuccessState) {
                          context.read<HabitsBloc>().add(UpdateHabitsEvent(
                              habit: habit.copyWith(
                                  streak: habit.streak + 1,
                                  lastCompleted: DateTime.now()),
                              userId: state.userId));

                          context
                              .read<UserCubit>()
                              .addExperience(experience: 10);
                        }
                      },
                icon: const Icon(
                  Icons.add,
                )),
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.remove,
            //       )),
          ],
        ),
      ),
    );
  }
}
