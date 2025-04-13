import 'package:flutter/material.dart';
import 'package:lifequest/core/widgets/fancy_button.dart';
import 'package:lifequest/features/groups/domain/entities/habit_template.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class AddHabitTemplateForm extends StatefulWidget {
  const AddHabitTemplateForm({super.key});

  @override
  State<AddHabitTemplateForm> createState() => _AddHabitTemplateFormState();
}

class _AddHabitTemplateFormState extends State<AddHabitTemplateForm> {
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

    final newHabit = HabitTemplate(
        title: _titleController.text,
        description: _descriptionController.text,
        frequency: _frequency,
        difficulty: _difficulty);

    Navigator.pop(context, newHabit);
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
