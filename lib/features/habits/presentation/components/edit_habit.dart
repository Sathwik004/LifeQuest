import 'package:flutter/material.dart';
import 'package:lifequest/core/widgets/fancy_button.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/domain/enums/habit_difficulty.dart';
import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

class EditHabitDialog extends StatefulWidget {
  final Habit habit;
  final void Function(Habit updatedHabit) onSave;
  final void Function() onDelete;

  const EditHabitDialog({
    super.key,
    required this.habit,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<EditHabitDialog> createState() => _EditHabitDialogState();
}

class _EditHabitDialogState extends State<EditHabitDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isActive;
  late HabitFrequency _frequency;
  late HabitDifficulty _difficulty;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habit.title);
    _descriptionController =
        TextEditingController(text: widget.habit.description);
    _isActive = widget.habit.isActive;
    _frequency = widget.habit.frequency;
    _difficulty = widget.habit.difficulty;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'Cancel',
              )),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              )),
        ],
      ),
    );
    if (confirmed == true) {
      widget.onDelete();
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _save() {
    final updatedHabit = Habit(
      id: widget.habit.id,
      title: _titleController.text,
      description: _descriptionController.text,
      streak: widget.habit.streak,
      lastCompleted: widget.habit.lastCompleted,
      isActive: _isActive,
      frequency: _frequency,
      difficulty: _difficulty,
    );
    widget.onSave(updatedHabit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Habit'),
      contentPadding: const EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 8.0),
            TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Text("Active"),
                const Spacer(),
                Switch(
                  value: _isActive,
                  onChanged: (val) => setState(() => _isActive = val),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
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
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      actions: [
        FancyButton(
          onPressed: _confirmDelete,
          size: 40,
          color: Colors.red,
          child: const Text(
            "Delete",
          ),
        ),
        // TextButton(
        //     onPressed: () => Navigator.pop(context),
        //     child: const Text('Cancel')),
        //ElevatedButton(onPressed: _save, child: const Text('Save')),
        FancyButton(size: 40, onPressed: _save, child: const Text("Save")),
      ],
    );
  }
}
