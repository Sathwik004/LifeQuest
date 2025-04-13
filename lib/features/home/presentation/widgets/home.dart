import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/bottom_nav_bar.dart';
import 'package:lifequest/features/groups/presentation/pages/group_page.dart';
import 'package:lifequest/features/habits/presentation/pages/habit_page.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';
import 'package:lifequest/features/user_profile/presentation/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const bottomAppBar = MyBottomNavBar();
    final List<Widget> pages = [
      const HabitPage(
        bottomAppBar: bottomAppBar,
      ),
      const GuildScreen(
        bottomAppBar: bottomAppBar,
      ),
      const UserPage(
        bottomAppBar: bottomAppBar,
      ),
    ];
    return BlocBuilder<BottomNavCubit, int>(builder: (context, selectedIndex) {
      return pages[selectedIndex];
      //       floatingActionButton: selectedIndex == 0
      //           ? FloatingActionButton(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(100),
      //               ),
      //               onPressed: () {
      //                 showModalBottomSheet(
      //                   context: context,
      //                   isScrollControlled: true,
      //                   builder: (_) => const AddHabitForm(),
      //                 );
      //                 print('Add habit');
      //               },
      //               child: const Icon(Icons.add),
      //             )
      //           : null,
      //       bottomNavigationBar: const MyBottomNavBar());
      // },
    });
  }
}
