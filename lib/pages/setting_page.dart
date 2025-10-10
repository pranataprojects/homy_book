import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const Color navy = Color(0xFF0D2A50);

  Future<void> _confirmAndSignOut(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sign out'),
        content:
            const Text('You will be signed out from this device. Continue?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Sign out')),
        ],
      ),
    );

    if (confirm != true) return;

    final messenger = ScaffoldMessenger.of(context);

    try {
      await AuthService.instance.signOut();
      messenger.showSnackBar(const SnackBar(content: Text('Signed out.')));
    } catch (_) {
      messenger
          .showSnackBar(const SnackBar(content: Text('Failed to sign out.')));
    }
    await AuthService.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign out',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
            onTap: () => _confirmAndSignOut(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white,
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F6FA),
    );
  }
}
