import 'package:flutter/material.dart';
import 'package:itdols/features/auth/presentation/login_page.dart';
import 'package:itdols/features/auth/presentation/registration_page.dart';
import 'package:itdols/core/widgets/main_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => MainPage(),
  '/login': (context) => LoginPage(),
  '/registration': (context) => RegistrationPage(),
};
