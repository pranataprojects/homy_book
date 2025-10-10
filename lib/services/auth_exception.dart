class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Map FirebaseAuthException codes to friendly messages
String mapAuthCodeToMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'E-mail tidak valid.';
    case 'user-disabled':
      return 'Akun ini dinonaktifkan.';
    case 'user-not-found':
      return 'Akun tidak ditemukan. Silakan daftar dahulu.';
    case 'wrong-password':
      return 'Password salah.';
    case 'email-already-in-use':
      return 'E-mail sudah terdaftar.';
    case 'weak-password':
      return 'Password terlalu lemah (gunakan kombinasi huruf & angka).';
    case 'operation-not-allowed':
      return 'Metode login ini sedang tidak diizinkan.';
    default:
      return 'Terjadi kesalahan. Coba lagi.';
  }
}
