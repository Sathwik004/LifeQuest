import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:lifequest/features/habits/presentation/components/add_habit.dart';
import 'package:lifequest/features/habits/presentation/components/habit_card.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key, required this.bottomAppBar});
  final Widget bottomAppBar;

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context: context, title: "Habits"),
      body: BlocBuilder<HabitsBloc, HabitsState>(
        builder: (context, state) {
          if (state is HabitsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitsErrorState) {
            return Center(child: Text("Error State${state.message}"));
          } else if (state is HabitsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemCount: state.habits.length,
                itemBuilder: (context, index) {
                  final habit = state.habits[index];
                  return HabitCard(habit: habit);
                },
              ),
            );
          }
          print(state);
          return const Center(child: Text("No habits found"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddHabitForm(),
          );
          print('Add habit');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: widget.bottomAppBar,
    );
  }
}
