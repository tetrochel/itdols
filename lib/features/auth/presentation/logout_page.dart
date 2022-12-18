import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/features/auth/user_controller.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Пользователь: ${ref.read(userStateHolder)!.username}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref.read(userController).setUser(null);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              'Выйти',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
