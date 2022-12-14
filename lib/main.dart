import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itdols/core/widgets/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff61caff),
        useMaterial3: true,
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MainPage(),
    );
  }
}
