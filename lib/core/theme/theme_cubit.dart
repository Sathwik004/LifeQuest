import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
