import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/core/widgets/dummy_screen.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/home/presentation/widgets/home.dart';
import 'package:lifequest/features/auth/presentation/pages/signup_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          title: 'LifeQuest',
          theme: state,
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthInitial) {
              return const SignInPage();
            } else if (state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthSuccessState) {
              return const HomePage();
            } else {
              return const DummyScreen(title: "Some error occurred");
            }
          }),
        );
      },
    );
  }
}
