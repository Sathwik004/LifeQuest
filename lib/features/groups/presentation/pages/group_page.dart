import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';

class GuildScreen extends StatelessWidget {
  const GuildScreen({super.key});
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
                  onPressed: () {
                    // TODO: Navigate to create group screen
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Create Group"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to search groups screen
                  },
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
              } else if (state is GroupLoaded) {
                return const Center(
                    child: Text("You are not part of any groups."));
                // return SingleChildScrollView(
                //   child: ListView.builder(
                //     itemCount: state.groups.length,
                //     itemBuilder: (context, index) {
                //       final group = state.groups[index];
                //       return ListTile(
                //         title: Text(group.name),
                //         subtitle: Text(group.description),
                //         leading: const Icon(Icons.group),
                //         onTap: () {
                //           // TODO: Open group details
                //         },
                //       );
                //     },
                //   ),
                // );
              } else if (state is GroupError) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return Center(child: Text("Something went wrong! ${state}"));
            },
          ),
        ),
      ],
    );
  }
}
