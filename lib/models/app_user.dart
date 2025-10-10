import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class AppStartup {
  static bool _initialized = false;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
  }
}

class AppUser {
  final String uid;
  final String? email;

  const AppUser({
    required this.uid,
    this.email,
  });

  static AppUser? fromFirebase(User? u) {
    if (u == null) return null;
    return AppUser(
      uid: u.uid,
      email: u.email,
    );
  }
}
