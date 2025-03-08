import 'package:flutter/material.dart';
import 'package:lifequest/core/utils/same_date.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';

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
            const Icon(Icons.star_border, size: 25),
            Text(
              habit.streak.toString(),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        subtitle: Text(habit.description),
        trailing: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.end,
          spacing: 2,
          children: [
            IconButton(
                onPressed: isSameDate(habit.lastCompleted)
                    ? null
                    : () => {
                          //

                          // update Streak here

                          //
                        },
                icon: const Icon(
                  Icons.add,
                )),
            // IconButton(
            //     onPressed: () => {},
            //     icon: const Icon(
            //       Icons.remove,
            //       size: 10,
            //     )),
          ],
        ),
      ),
    );
  }
}
