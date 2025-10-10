import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';
import 'auth_exception.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AppUser?> authState() =>
      _auth.authStateChanges().map(AppUser.fromFirebase);

  AppUser? get currentUser => AppUser.fromFirebase(_auth.currentUser);

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AppUser.fromFirebase(cred.user)!;
    } on FirebaseAuthException catch (e) {
      throw AuthException(mapAuthCodeToMessage(e.code));
    }
  }

  Future<void> signOut() => _auth.signOut();
}
