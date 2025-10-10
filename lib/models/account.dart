
class Account {
  final String id;
  final String name;
  final num balance;

  Account({required this.id, required this.name, required this.balance});

  factory Account.fromMap(String id, Map<String, dynamic> data) {
    return Account(
      id: id,
      name: (data['name'] ?? '') as String,
      balance: (data['balance'] ?? 0) as num,
    );
  }
}
