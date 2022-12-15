import 'package:flutter/material.dart';

void showMessage(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1200),
    backgroundColor: Colors.red,
    content: Text(
      text,
    ),
  ));
}
