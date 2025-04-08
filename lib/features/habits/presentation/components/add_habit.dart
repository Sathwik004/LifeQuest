import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/fancy_button.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class AddHabitForm extends StatefulWidget {
  const AddHabitForm({super.key});

  @override
  State<AddHabitForm> createState() => _AddHabitFormState();
}

class _AddHabitFormState extends State<AddHabitForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late HabitFrequency _frequency;
  late HabitDifficulty _difficulty;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _frequency = HabitFrequency.daily;
    _difficulty = HabitDifficulty.easy;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitHabit() {
    if (_titleController.text.isEmpty) return;

    final newHabit = Habit(
        id: uuid.v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        streak: 0,
        lastCompleted: DateTime(1999, 9, 9),
        isActive: true,
        frequency: _frequency,
        difficulty: _difficulty);

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccessState) {
      context
          .read<HabitsBloc>()
          .add(AddHabitsEvent(habits: newHabit, userId: authState.userId));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text('Habit has been created! ${newHabit.title}'),
      ),
    );
    Navigator.pop(context); // Close bottom sheet after submission
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Add New Habit!",
            style: Theme.of(context).copyWith().textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),
          TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Habit Title')),
          const SizedBox(height: 8.0),
          TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 10.0),
          DropdownButtonFormField<HabitFrequency>(
            value: _frequency,
            decoration: const InputDecoration(labelText: 'Frequency'),
            onChanged: (val) => setState(() => _frequency = val!),
            items: HabitFrequency.values.map((freq) {
              return DropdownMenuItem(
                value: freq,
                child: Text(freq.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          DropdownButtonFormField<HabitDifficulty>(
            value: _difficulty,
            decoration: const InputDecoration(labelText: 'Difficulty'),
            onChanged: (val) => setState(() => _difficulty = val!),
            items: HabitDifficulty.values.map((diff) {
              return DropdownMenuItem(
                value: diff,
                child: Text(diff.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          FancyButton(
              onPressed: _submitHabit,
              size: 60,
              child: const Text('Create Habit')),
        ],
      ),
    );
  }
}
