import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/core/widgets/fancy_button.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/domain/entities/habit_template.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/groups/presentation/components/habit_template_form.dart';
import 'package:uuid/uuid.dart';

class GroupCreationPage extends StatefulWidget {
  const GroupCreationPage({super.key});

  @override
  State<GroupCreationPage> createState() => _GroupCreationPageState();
}

class _GroupCreationPageState extends State<GroupCreationPage> {
  final _formKey = GlobalKey<FormState>();
  late String userId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Color _badgeColor = Colors.blue;
  final List<HabitTemplate> _habits = [];
  int _habitCount = 0;

  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccessState) {
      userId = authState.userId;
    } else {
      userId = ""; // Handle the case where userId is not available
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick the Badge Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _badgeColor,
              onColorChanged: (color) {
                setState(() {
                  _badgeColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _addHabit() async {
    if (_habitCount < 5) {
      final HabitTemplate? newHabit = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const AddHabitTemplateForm(),
      );
      if (newHabit != null) {
        setState(() {
          _habits.add(newHabit);
          _habitCount++;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can only add up to 5 habits.'),
        ),
      );
    }
  }

  void _removeHabit(int index) {
    if (_habitCount > 0) {
      setState(() {
        _habits.removeAt(index);
        _habitCount--;
      });
    }
  }

  void _showPreview(Groups group) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Group?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${group.name}'),
              Text('Description: ${group.description}'),
              Text('Badge Color: ${group.badgeColor}'),
              const SizedBox(height: 20),
              const Text('Habits:'),
              ...group.habits.map((habit) => HabitWidget(
                    habitTemplate: habit,
                  )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<GroupBloc>().add(CreateGroupEvent(group));
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Groups _createGroup() {
    final group = Groups(
      id: const Uuid().v4(),
      name: _nameController.text,
      description: _descriptionController.text,
      creatorId: userId, // Replace with actual user ID
      memberIds: [userId],
      badgeColor: _badgeColor.toHexString(),
      createdAt: DateTime.now(),
      habits: _habits,
    );

    // Save the group (e.g., send it to a backend or store locally)
    print('Group Created: ${group}');
    return group;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: "Create Group",
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Group Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _pickColor,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: _badgeColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Badge Color'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Habits:',
                    ),
                    const SizedBox(height: 20),
                    _habitCount < 5
                        ? IconButton(
                            onPressed: _addHabit,
                            iconSize: 24,
                            icon: const Icon(Icons.add))
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 10),
                for (HabitTemplate habit in _habits)
                  HabitWidget(
                    habitTemplate: habit,
                    onRemove: () => _removeHabit(_habits.indexOf(habit)),
                  ),
                const SizedBox(height: 30),
                FancyButton(
                  size: 40,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final group = _createGroup();
                      _showPreview(group);
                    }
                  },
                  child: const Text('Preview and Create Group'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HabitWidget extends StatelessWidget {
  final VoidCallback? onRemove;
  final HabitTemplate habitTemplate;

  const HabitWidget({super.key, this.onRemove, required this.habitTemplate});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(habitTemplate.title),
      subtitle: Text(
          'Description: ${habitTemplate.description}\nFrequency: ${habitTemplate.frequency.name}\nDifficulty: ${habitTemplate.difficulty.name}'),
      trailing: onRemove == null
          ? const SizedBox()
          : IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: onRemove,
            ),
    );
  }
}
