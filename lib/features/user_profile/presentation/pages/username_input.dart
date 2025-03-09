import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifequest/features/user_profile/presentation/bloc/cubit/user_cubit.dart';

class UsernameInputPage extends StatefulWidget {
  final String userId;

  const UsernameInputPage({super.key, required this.userId});

  @override
  State<UsernameInputPage> createState() => _UsernameInputPageState();
}

class _UsernameInputPageState extends State<UsernameInputPage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  void _registerUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username cannot be empty")),
      );
      return;
    }

    await context.read<UserCubit>().registerUser(widget.userId, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose a Username")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Enter Username"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => _registerUser(context),
                    child: const Text("Continue"),
                  ),
          ],
        ),
      ),
    );
  }
}
