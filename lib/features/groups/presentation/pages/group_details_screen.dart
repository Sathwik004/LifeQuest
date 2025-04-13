import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/habits/domain/entities/habits.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';

class GroupDetailScreen extends StatelessWidget {
  final Groups group;
  final String currentUserId;

  const GroupDetailScreen({
    super.key,
    required this.group,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final isMember = group.memberIds.contains(currentUserId);

    return Scaffold(
      appBar: MyAppBar(context: context, title: group.name, actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(group.description),
            const SizedBox(height: 20),
            Text("Members: ${group.memberIds.length}"),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: group.habits.length,
                itemBuilder: (context, index) {
                  final habit = group.habits[index];
                  return ListTile(
                    title: Text(habit.title),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(habit.description),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Frequency : ${habit.frequency.name}'),
                            Text('Difficulty : ${habit.difficulty.name}'),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            BlocConsumer<GroupBloc, GroupState>(
              listener: (context, state) {
                if (state is GroupError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is GroupLoading;
                return Center(
                  child: ElevatedButton.icon(
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : Icon(isMember ? Icons.exit_to_app : Icons.group_add),
                    label: Text(isMember ? 'Leave Group' : 'Join'),
                    onPressed: isLoading
                        ? null
                        : () {
                            if (isMember) {
                              context.read<HabitsBloc>().add(
                                  RemoveGroupHabitsEvent(
                                      groupId: group.id,
                                      userId: currentUserId));
                              context.read<GroupBloc>().add(
                                    LeaveGroupEvent(
                                      groupId: group.id,
                                      userId: currentUserId,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            } else {
                              context.read<GroupBloc>().add(
                                    JoinGroupEvent(
                                      groupId: group.id,
                                      userId: currentUserId,
                                    ),
                                  );
                              context.read<HabitsBloc>().add(
                                    AddHabitsFromGroupEvent(
                                      userId: currentUserId,
                                      habits: group.habits.map((template) {
                                        return Habit.fromTemplate(template,
                                            groupId: group.id);
                                      }).toList(),
                                    ),
                                  );
                              Navigator.of(context).pop();
                            }
                          },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
