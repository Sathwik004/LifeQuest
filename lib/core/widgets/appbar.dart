import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final List<Widget>? actions;
  const MyAppBar(
      {super.key,
      required this.context,
      this.title = 'LifeQuest',
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text(title),
      actions: actions ??
          [
            IconButton(
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Logout'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true && context.mounted) {
                    context.read<AuthBloc>().add(AuthSignOut());
                  }
                },
                icon: const Icon(Icons.logout)),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); //+ MediaQuery.of(context).padding.top);
}
