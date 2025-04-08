import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:sign_button/sign_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(
              height: 60,
            ),
            SignInButton(
              buttonType: ButtonType.google,
              padding: 10.0,
              btnColor: Theme.of(context).primaryColor,
              btnTextColor: Colors.white,
              onPressed: () {
                // Define your onPressed functionality here
                context.read<AuthBloc>().add(
                      AuthSignIn(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
