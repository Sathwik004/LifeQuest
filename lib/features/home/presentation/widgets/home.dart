import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/widgets/appbar.dart';
import 'package:lifequest/core/widgets/bottom_nav_bar.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    const Center(child: Text('Quests Page')),
    const Center(child: Text('Guilds Page')),
    const Center(child: Text('Stats Page')),
  ];

  @override
  Widget build(BuildContext context) {
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
