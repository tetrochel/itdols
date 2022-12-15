import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/auth/domain/models/user_model.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/core/states/widget_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(WidgetState.loading),
);

Provider<UserController> userController = Provider<UserController>(
  (ref) => UserController(
    userStateHolder: ref.watch(userStateHolder.notifier),
  ),
);

class UserController {
  final UserStateHolder userStateHolder;
  UserController({
    required this.userStateHolder,
  });

  // TODO: contacting the API
  Future getUser(String username) async {
    setUser(UserModel(username: username, token: '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'));
  }

  Future setUser(UserModel user) async {
    userStateHolder.setUser(user);
  }
}
