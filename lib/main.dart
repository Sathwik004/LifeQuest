import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:lifequest/features/home/presentation/cubits/bottom_nav.dart';
import 'package:lifequest/firebase_options.dart';
import 'package:lifequest/init_dependencies.dart';
import 'package:lifequest/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Pass all the blocs here
        BlocProvider<AuthBloc>(
          create: (context) => serviceLocater<AuthBloc>()..add(AuthCheck()),
        ),

        BlocProvider<BottomNavCubit>(
          create: (context) => serviceLocater<BottomNavCubit>(),
        ),

        BlocProvider<ThemeCubit>(
          create: (context) => serviceLocater<ThemeCubit>(),
        ),

        BlocProvider<HabitsBloc>(
          create: (context) => serviceLocater<HabitsBloc>(),
        )
      ],
      child: const MainScreen(),
    );
  }
}
