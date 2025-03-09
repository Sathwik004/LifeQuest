import 'package:lifequest/features/user_profile/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final UserEntity user;

  const UserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${user.username}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username: ${user.username}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("Level: ${user.level}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Health: ${user.health}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Experience: ${user.experience}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
