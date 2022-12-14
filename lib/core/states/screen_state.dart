import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<ScreenStateHolder, int> screenStateHolder = StateNotifierProvider<ScreenStateHolder, int>(
  (ref) => ScreenStateHolder(0),
);

class ScreenStateHolder extends StateNotifier<int> {
  ScreenStateHolder(super.state);

  void setScreen(int newSreen) {
    state = newSreen;
  }
}
