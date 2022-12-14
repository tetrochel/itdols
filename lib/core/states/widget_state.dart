import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WidgetState {
  loaded,
  loading,
  error,
}

class WidgetStateHolder extends StateNotifier<WidgetState> {
  WidgetStateHolder(super.state);

  void setWidgetState(WidgetState newWidgetState) {
    state = newWidgetState;
  }
}
