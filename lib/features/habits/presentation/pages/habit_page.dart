import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  @override
  void initState() {
    super.initState();
    if (context.read<HabitsBloc>().state is HabitsInitial) {
      print("📢 Dispatching GetHabitsEvent...");
      context.read<HabitsBloc>().add(GetHabitsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsBloc, HabitsState>(
      builder: (context, state) {
        if (state is HabitsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HabitsErrorState) {
          return Center(child: Text("Error State${state.message}"));
        } else if (state is HabitsLoaded) {
          return ListView.builder(
            itemCount: state.habits.length,
            itemBuilder: (context, index) {
              final habit = state.habits[index];
              return ListTile(
                title: Text(habit.title),
                subtitle: Text("Streak: ${habit.streak}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<HabitsBloc>().add(RemoveHabitsEvent(habit.id));
                  },
                ),
              );
            },
          );
        }
        print(state);
        return const Center(child: Text("No habits found"));
      },
    );
  }
}
