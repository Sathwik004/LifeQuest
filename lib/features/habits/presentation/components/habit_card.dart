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
      child: Container(
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     border: const Border(
        //       bottom: BorderSide(color: Colors.grey, width: 4),
        //       top: BorderSide(color: Colors.grey, width: 1),
        //       left: BorderSide(color: Colors.grey, width: 1),
        //       right: BorderSide(color: Colors.grey, width: 4),
        //     )),
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
          onTap: () {
            //TODO: Add edit habit functionality
            //TODO: Add delete habit functionality
            // print("Tyring to delete habit with id: ${habit.id}");
            // final state = context.read<AuthBloc>().state;

            // if (state is AuthSuccessState) {
            //   context.read<HabitsBloc>().add(
            //       RemoveHabitsEvent(habitId: habit.id, userId: state.userId));
            // }
          },
          trailing: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.end,
            spacing: 2,
            children: [
              Checkbox(
                value: isSameDate(habit.lastCompleted),
                onChanged: isSameDate(habit.lastCompleted)
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

                            context
                                .read<UserCubit>()
                                .addExperience(experience: 10);
                          }
                        }
                      },
              ),
              //   IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.remove,
              //       )),
            ],
          ),
        ),
      ),
    );
  }
}
