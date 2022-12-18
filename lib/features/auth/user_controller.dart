import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/auth/domain/data/api/auth_api_methods.dart';
import 'package:itdols/features/auth/domain/data/local_user.dart';
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

  Future<bool> registerUser(String username, String password) async {
    String? token = await AuthAPIMethods.registerUser(username, password);
    if (token != null) {
      await setUser(UserModel(username: username, token: token));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    String? token = await AuthAPIMethods.loginUser(username, password);
    if (token != null) {
      await setUser(UserModel(username: username, token: token));
      return true;
    } else {
      return false;
    }
  }

  Future setUser(UserModel? user) async {
    await LocalUser.setUser(user);
    userStateHolder.setUser(user);
  }
}
