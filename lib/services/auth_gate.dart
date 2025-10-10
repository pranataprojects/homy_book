import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return (snap.data != null) ? const HomePage() : const LoginPage();
      },
    );
  }
}
