import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  const MyAppBar({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: const Text('LifeQuest'),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                child: const Text('Change Theme'),
              ),
              PopupMenuItem(
                onTap: () async {
                  context.read<AuthBloc>().add(
                        AuthSignOut(),
                      );
                },
                child: const Text('Sign out'),
              )
            ];
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); //+ MediaQuery.of(context).padding.top);
}
