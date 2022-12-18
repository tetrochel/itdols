import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/auth/domain/models/user_model.dart';

StateNotifierProvider<UserStateHolder, UserModel?> userStateHolder = StateNotifierProvider<UserStateHolder, UserModel?>(
  (ref) => UserStateHolder(null),
);

class UserStateHolder extends StateNotifier<UserModel?> {
  UserStateHolder(super.state);

  void setUser(UserModel? user) {
    state = user;
  }

  UserModel? getUser() {
    return state;
  }
}
