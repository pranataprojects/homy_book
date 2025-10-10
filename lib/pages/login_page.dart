import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool hide = true;
  bool loading = false;
  static const Color navy = Color(0xFF0D2A50);

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  String _authMessage(String code) {
    if (code == 'invalid-email') return 'E-mail tidak valid.';
    if (code == 'user-disabled') return 'Akun dinonaktifkan.';
    if (code == 'user-not-found') return 'Akun tidak ditemukan.';
    if (code == 'wrong-password') return 'Password salah.';
    return 'Login gagal: $code';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.white38,
                    child: Icon(Icons.account_circle,
                        size: 60, color: Colors.white)),
                const SizedBox(height: 24),
                const Text('HOMY BOOK',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        letterSpacing: 1.2)),
                const SizedBox(height: 28),
                TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(hintText: 'e-mail address')),
                const SizedBox(height: 14),
                TextField(
                  controller: pass,
                  obscureText: hide,
                  decoration: InputDecoration(
                      hintText: 'password',
                      suffixIcon: IconButton(
                          icon: Icon(
                              hide ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => hide = !hide))),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1792E8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: loading
                        ? null
                        : () async {
                            final em = email.text.trim();
                            final pw = pass.text;

                            final messenger = ScaffoldMessenger.of(context);

                            if (em.isEmpty || pw.isEmpty) {
                              messenger.showSnackBar(const SnackBar(
                                  content:
                                      Text('Please enter email & password')));
                              return;
                            }

                            setState(() => loading = true);
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: em, password: pw);

                              if (!mounted) return;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => const HomePage()),
                              );
                            } on FirebaseAuthException catch (e) {
                              final msg = _authMessage(e.code);
                              messenger
                                  .showSnackBar(SnackBar(content: Text(msg)));
                            } catch (_) {
                              messenger.showSnackBar(const SnackBar(
                                  content:
                                      Text('Terjadi kesalahan. Coba lagi.')));
                            } finally {
                              if (mounted) setState(() => loading = false);
                            }
                          },
                    child: loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                    text: TextSpan(
                        text: "don't have an account? ",
                        style: const TextStyle(color: Colors.white70),
                        children: [
                      TextSpan(
                          text: 'register here',
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Register not implemented in this starter.')));
                            })
                    ])),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
