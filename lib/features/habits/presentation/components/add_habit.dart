import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:uuid/uuid.dart';

final Uuid uuid = Uuid();

class AddHabitForm extends StatefulWidget {
  const AddHabitForm({super.key});

  @override
  State<AddHabitForm> createState() => _AddHabitFormState();
}

class _AddHabitFormState extends State<AddHabitForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedFrequency = 'Daily';

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
    );

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccessState) {
      print('Adding habit\n\n\n');
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
          const SizedBox(height: 10),
          TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Habit Title')),
          const SizedBox(height: 10),
          TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description')),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownButton<String>(
              value: _selectedFrequency,
              onChanged: (value) => setState(() => _selectedFrequency = value!),
              items: ['Daily', 'Weekly', 'Monthly']
                  .map((freq) =>
                      DropdownMenuItem(value: freq, child: Text(freq)))
                  .toList(),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: FloatingActionButton(
                onPressed: _submitHabit, child: const Text('Create Habit')),
          ),
        ],
      ),
    );
  }
}
