import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/features/auth/user_controller.dart';

class RegistrationPage extends ConsumerWidget {
  RegistrationPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Регистрация',
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
                    onFieldSubmitted: (value) => {secondFocusNode.requestFocus()},
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
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
                    focusNode: secondFocusNode,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(fontSize: 20),
                    controller: repeatPasswordController,
                    onFieldSubmitted: (value) => finishRegistration(context, ref),
                    decoration: const InputDecoration(
                      labelText: 'Повтор пароля',
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
                    onPressed: () => finishRegistration(context, ref),
                    child: const Text(
                      'Зарегистрироваться',
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
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'Вход',
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

  void finishRegistration(BuildContext context, WidgetRef ref, [bool mounted = true]) async {
    if (usernameController.text.isEmpty) {
      showMessage('Введите логин!', context);
      return;
    }
    if (passwordController.text.isEmpty) {
      showMessage('Введите пароль!', context);
      return;
    }
    if (passwordController.text != repeatPasswordController.text) {
      showMessage('Пароли должны совпадать!', context);
      return;
    }
    await ref.read(userController).addUser(usernameController.text, passwordController.text);
    if (ref.read(userStateHolder) != null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    } else {
      if (!mounted) return;
      showMessage('Ошибка регистрации!', context);
    }
    return;
  }
}
