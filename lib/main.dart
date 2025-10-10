import 'package:flutter/material.dart';
import 'package:homy_book/pages/login_page.dart';
import 'core/app_startup.dart';
import 'services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStartup.ensureInitialized();
  runApp(const HomyBookApp());
}

class HomyBookApp extends StatelessWidget {
  const HomyBookApp({super.key});

  static const Color navy = Color(0xFF0D2A50);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homy Book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
  /*
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
        home => const 
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(), //HomePage(),
        
      },
    );
  }
  */
}
