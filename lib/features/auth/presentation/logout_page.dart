import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/auth/user_controller.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(userController).setUser(null);
          print('sdasda');
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: const Text(
          'Выйти',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
