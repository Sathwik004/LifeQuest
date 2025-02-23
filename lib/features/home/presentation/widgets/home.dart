import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/core/widgets/bottom_nav_bar.dart';
import 'package:lifequest/features/habits/presentation/pages/habit_page.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';

class HomePage extends StatefulWidget {
  final userId;

  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HabitPage(),
      const Center(child: Text('Guilds Page')),
      const Center(child: Text('Stats Page')),
    ];
    return Scaffold(
        appBar: MyAppBar(context: context),
        body: BlocBuilder<BottomNavCubit, int>(
          builder: (context, selectedIndex) {
            return pages[selectedIndex]; // Show selected page
          },
        ),
        bottomNavigationBar: MyBottomNavBar());
  }
}
