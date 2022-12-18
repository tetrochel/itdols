import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/screen_state.dart';
import 'package:itdols/core/widgets/main_page.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/features/auth/domain/data/local_user.dart';
import 'package:itdols/features/auth/domain/models/user_model.dart';
import 'package:itdols/features/auth/user_controller.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: isUserGetted(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return MainPage();
          }
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Вход',
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: usernameController,
                          onFieldSubmitted: (value) => {focusNode.requestFocus()},
                          decoration: const InputDecoration(
                            labelText: 'Логин',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextFormField(
                          focusNode: focusNode,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: const TextStyle(fontSize: 20),
                          controller: passwordController,
                          onFieldSubmitted: (value) => finishLogin(context, ref),
                          decoration: const InputDecoration(
                            labelText: 'Пароль',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => finishLogin(context, ref),
                          child: const Text(
                            'Вход',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/registration');
                          },
                          child: const Text(
                            'Регистрация',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SafeArea(
          child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Future<bool> isUserGetted(WidgetRef ref) async {
    UserModel? user = await LocalUser.getUser();
    if (user == null) {
      return false;
    }
    await ref.read(userController).setUser(user);
    return true;
  }

  void finishLogin(BuildContext context, WidgetRef ref, [bool mounted = true]) async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (username.isEmpty) {
      showMessage('Введите логин!', context);
      return;
    }
    if (password.isEmpty) {
      showMessage('Введите пароль!', context);
      return;
    }
    if (await ref.read(userController).loginUser(username, password)) {
      if (!mounted) return;
      ref.read(screenStateHolder.notifier).setScreen(0);
      Navigator.pushReplacementNamed(context, '/');
    } else {
      if (!mounted) return;
      showMessage('Ошибка входа!', context);
    }
    return;
  }
}
