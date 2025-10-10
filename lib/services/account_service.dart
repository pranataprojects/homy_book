import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/account.dart';

class AccountService {
  AccountService._();
  static final AccountService instance = AccountService._();

  final _db = FirebaseFirestore.instance;

  String _requireUid() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw StateError('Not signed in');
    }
    return uid;
  }

  Stream<List<Account>> streamMyAccounts() {
    final uid = _requireUid();
    return _db
        .collection('users').doc(uid).collection('accounts')
        .orderBy('name')
        .snapshots()
        .map((s) => s.docs.map((d) => Account.fromMap(d.id, d.data())).toList());
  }
}
