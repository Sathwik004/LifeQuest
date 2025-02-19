import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, selectedIndex) {
        return SalomonBottomBar(
            currentIndex: selectedIndex,
            onTap: (index) =>
                {context.read<BottomNavCubit>().updateIndex(index)},
            selectedItemColor: Colors.deepPurple,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.list),
                title: const Text(
                  'Quests',
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.shield),
                title: const Text(
                  'Guilds',
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.water_drop),
                title: const Text(
                  'Stats',
                ),
              ),
            ]);
      },
    );
  }
}
