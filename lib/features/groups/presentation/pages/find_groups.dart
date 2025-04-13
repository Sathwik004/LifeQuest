import 'package:flutter/material.dart';
import 'package:lifequest/features/groups/domain/entities/group_entity.dart';
import 'package:lifequest/features/groups/domain/usecases/discover_group.dart';
import 'package:lifequest/features/groups/presentation/pages/group_details_screen.dart';
import 'package:lifequest/init_dependencies.dart';

class DiscoverGroupsScreen extends StatefulWidget {
  const DiscoverGroupsScreen({super.key, required this.currentUserId});

  final String currentUserId;

  @override
  State<DiscoverGroupsScreen> createState() => _DiscoverGroupsScreenState();
}

class _DiscoverGroupsScreenState extends State<DiscoverGroupsScreen> {
  late Future<List<Groups>> _groupsFuture;

  @override
  void initState() {
    super.initState();
    _groupsFuture = _loadGroups();
  }

  Future<List<Groups>> _loadGroups() async {
    final result = await serviceLocator<DiscoverGroups>()(20);
    return result.fold((failure) => [], (groups) => groups);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discover Groups")),
      body: FutureBuilder<List<Groups>>(
        future: _groupsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Something went wrong."));
          }
          final groups = snapshot.data!;
          if (groups.isEmpty) {
            return const Center(child: Text("No groups found."));
          }
          return ListView.separated(
            itemCount: groups.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                title: Text(group.name),
                subtitle: Text(group.description),
                leading: CircleAvatar(
                  backgroundColor: Color(
                    int.parse("0xFF${group.badgeColor.replaceAll('#', '')}"),
                  ),
                  child: const Icon(Icons.group, color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupDetailScreen(
                        group: group,
                        currentUserId: widget.currentUserId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


// TODO: connect group page to this, remove discover group event from groups bloc