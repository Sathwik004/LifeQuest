import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0); // Default index is 0 (Quests)

  void updateIndex(int newIndex) {
    emit(newIndex);
  }
}
