import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lifequest/core/widgets/dummy_screen.dart';
import 'package:lifequest/features/user_profile/presentation/bloc/cubit/user_cubit.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is UserLoaded) {
          final user = state.user;
          int maxExperience = user.level * 5 + 100;
          int displayedExperience =
              user.experience > maxExperience ? maxExperience : user.experience;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting with level badge
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Greetings, ${user.username}!",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Lvl ${user.level}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Health Bar
                  const Text(
                    "Health:",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text("${user.health} / 100"),
                  _buildProgressBar(
                      user.health, 100, const Color.fromARGB(255, 226, 66, 55)),

                  const SizedBox(height: 20),

                  // Experience Bar
                  const Text(
                    "Experience:",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$displayedExperience / $maxExperience",
                  ),
                  _buildProgressBar(displayedExperience, maxExperience,
                      const Color.fromARGB(255, 83, 177, 255)),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else {
          return const DummyScreen(title: "Something went wrong!");
        }
      },
    );
  }

  Widget _buildProgressBar(int value, int maxValue, Color color) {
    return Stack(
      children: [
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Container(
          height: 20,
          width: (value / maxValue) * 200, // Dynamic width
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  // Styling for stat titles
  static const TextStyle _statTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
