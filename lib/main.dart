import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const HomyBookApp());
}

class HomyBookApp extends StatelessWidget {
  const HomyBookApp({super.key});
  static const Color navy = Color(0xFF0D2A50);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homy Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      routes: {
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
