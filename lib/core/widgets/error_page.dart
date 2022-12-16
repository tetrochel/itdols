import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ошибка сети',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(onPressed: onPressed, icon: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
