import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/groups/presentation/pages/create_group.dart';
import 'package:lifequest/features/groups/presentation/pages/find_groups.dart';
import 'package:lifequest/features/groups/presentation/pages/group_details_screen.dart';

class GuildScreen extends StatefulWidget {
  final Widget bottomAppBar;
  const GuildScreen({super.key, required this.bottomAppBar});

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
      userId = "";
    }
    super.initState();
  }

  void _openCreateGroupScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupCreationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: "Guilds",
      ),
      body: Column(
        children: [
          // Search & Create Group Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openCreateGroupScreen,
                    icon: const Icon(Icons.add),
                    label: const Text("Create Group"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiscoverGroupsScreen(
                            currentUserId: userId,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("Find Groups"),
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
                          backgroundColor: Color(
                            int.parse(
                                "0xFF${group.badgeColor.replaceAll('#', '')}"),
                          ),
                          child: const Icon(Icons.group, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupDetailScreen(
                                group: group,
                                currentUserId: userId,
                              ),
                            ),
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
      ),
      bottomNavigationBar: widget.bottomAppBar,
    );
  }
}
