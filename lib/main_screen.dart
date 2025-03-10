import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/core/theme/theme_cubit.dart';
import 'package:lifequest/core/widgets/dummy_screen.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:lifequest/features/groups/presentation/bloc/bloc/group_bloc.dart';
import 'package:lifequest/features/habits/presentation/bloc/habits_bloc/habits_bloc.dart';
import 'package:lifequest/features/home/presentation/widgets/home.dart';
import 'package:lifequest/features/auth/presentation/pages/signup_screen.dart';
import 'package:lifequest/features/user_profile/presentation/bloc/cubit/user_cubit.dart';
import 'package:lifequest/features/user_profile/presentation/pages/username_input.dart';

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
          home: BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInitial || state is AuthLoggedOutState) {
                return const SignInPage();
              } else if (state is AuthLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthSuccessState) {
                return _handleUserCheck(context, state.userId);
              } else {
                return const DummyScreen(title: "Some error occurred");
              }
            },
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                // Reset user and habit states when logging out
                context.read<UserCubit>().reset();
                context.read<HabitsBloc>().add(HabitsResetEvent());
              } else if (state is AuthSuccessState) {
                // Load habits when user logs in
                context
                    .read<HabitsBloc>()
                    .add(GetHabitsEvent(userId: state.userId));
                context
                    .read<GroupBloc>()
                    .add(FetchUserGroups(userId: state.userId));
              }
            },
          ),
        );
      },
    );
  }

  Widget _handleUserCheck(BuildContext context, String userId) {
    // Call checkUser in UserCubit
    BlocProvider.of<UserCubit>(context).checkUser(userId);

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserNotRegistered) {
          return UsernameInputPage(userId: userId);
        } else if (state is UserLoaded) {
          return HomePage(userId: userId);
        } else if (state is UserError) {
          return DummyScreen(title: state.message);
        } else {
          return const DummyScreen(title: "Some error occurred2");
        }
      },
    );
  }
}
