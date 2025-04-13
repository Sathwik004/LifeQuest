import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';

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
                    label: Text(isMember ? 'Leave Group' : 'Join Group'),
                    onPressed: isLoading
                        ? null
                        : () {
                            if (isMember) {
                              context.read<GroupBloc>().add(
                                    LeaveGroupEvent(
                                      groupId: group.id,
                                      userId: currentUserId,
                                    ),
                                  );
                            } else {
                              context.read<GroupBloc>().add(
                                    JoinGroupEvent(
                                      groupId: group.id,
                                      userId: currentUserId,
                                    ),
                                  );
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
