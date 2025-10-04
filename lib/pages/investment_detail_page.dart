import 'package:flutter/material.dart';
import 'add_investment_page.dart';

class InvestmentDetailPage extends StatelessWidget {
  final String title;
  final List<Map<String, Object>> transactions;

  const InvestmentDetailPage({
    super.key,
    this.title = 'Investment Detail',
    this.transactions = const [
      {'type': 'Top Up', 'date': '2025-10-02', 'amount': 200000},
      {'type': 'Profit', 'date': '2025-10-01', 'amount': 15000},
      {'type': 'Withdraw', 'date': '2025-09-30', 'amount': 50000},
      {'type': 'Top Up', 'date': '2025-09-28', 'amount': 100000},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.green),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12, left: 4),
            child: Text('Transactions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ),
          for (final tx in transactions) ...[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                    child: Icon(_iconFor(tx['type'] as String? ?? '-'))),
                title: Text(
                  '${tx['type'] ?? '-'} • ${_dateText(tx['date'])}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  'Rp ${_amountText(tx['amount'])}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddInvestmentPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static String _dateText(Object? d) {
    if (d == null) return '-';
    if (d is String) return d; // already mock string like 2025-10-02
    if (d is DateTime) return d.toIso8601String().split('T').first; // fallback
    return d.toString();
  }

  static String _amountText(Object? a) {
    final n = (a is num) ? a : num.tryParse(a.toString()) ?? 0;
    return n.toString(); // simple mock, no thousands separator
  }

  static IconData _iconFor(String type) {
    final t = type.toLowerCase();
    if (t.contains('withdraw')) return Icons.south_west;
    if (t.contains('profit')) return Icons.trending_up;
    return Icons.north_east; // Top Up default
  }
}
