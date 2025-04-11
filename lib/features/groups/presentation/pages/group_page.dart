import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:uuid/uuid.dart';

class GuildScreen extends StatefulWidget {
  const GuildScreen({super.key});

  @override
  State<GuildScreen> createState() => _GuildScreenState();
}

class _GuildScreenState extends State<GuildScreen> {
  late String userId;

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

  void _createDummyGroup() {
    final group = Groups(
      id: const Uuid().v4(),
      name: "Test Group ${DateTime.now().second}",
      description: "This is a test group",
      creatorId: userId,
      memberIds: [userId],
      badgeColor: "#FF5733",
      createdAt: DateTime.now(),
      habits: [],
    );
    context.read<GroupBloc>().add(CreateGroupEvent(group));
  }

  void _discoverGroups() {
    context.read<GroupBloc>().add(const DiscoverGroupsEvent(limit: 20));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search & Create Group Buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _createDummyGroup,
                  icon: const Icon(Icons.add),
                  label: const Text("Create Group"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _discoverGroups,
                  icon: const Icon(Icons.search),
                  label: const Text("Search Groups"),
                ),
              ),
            ],
          ),
        ),

        // List of groups the user is part of
        Expanded(
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GroupOperationSuccess) {
                if (state.groups.isEmpty) {
                  return const Center(
                      child: Text("You are not part of any groups."));
                }
                return ListView.builder(
                  itemCount: state.groups.length,
                  itemBuilder: (context, index) {
                    final group = state.groups[index];
                    return ListTile(
                      title: Text(group.name),
                      subtitle: Text(group.description),
                      leading: CircleAvatar(
                        backgroundColor: Color(int.parse(
                            "0xFF${group.badgeColor.replaceAll('#', '')}")),
                        child: const Icon(Icons.group, color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.exit_to_app),
                        onPressed: () {
                          context.read<GroupBloc>().add(
                                LeaveGroupEvent(
                                    groupId: group.id, userId: userId),
                              );
                        },
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Clicked on ${group.name}")),
                        );
                      },
                    );
                  },
                );
              } else if (state is GroupError) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is GroupEmpty) {
                return const Center(child: Text("No groups found."));
              }
              return const Center(child: Text("Idle state."));
            },
          ),
        ),
      ],
    );
  }
}
