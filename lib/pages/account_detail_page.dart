import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountDetailPage extends StatelessWidget {
  final List<Map<String, Object>> _transactions = const [
    {
      'date': '2025-10-03',
      'type': 'Income',
      'category': 'Salary',
      'amount': 2000000,
      'note': 'October payroll'
    },
    {
      'date': '2025-10-02',
      'type': 'Expense',
      'category': 'Food',
      'amount': 85000,
      'note': 'Lunch with team'
    },
    {
      'date': '2025-10-02',
      'type': 'Expense',
      'category': 'Transport',
      'amount': 25000,
      'note': 'MRT ticket'
    },
    {
      'date': '2025-10-01',
      'type': 'Income',
      'category': 'Refund',
      'amount': 50000,
      'note': 'Wallet top-up refund'
    },
    {
      'date': '2025-09-30',
      'type': 'Expense',
      'category': 'Bills',
      'amount': 150000,
      'note': 'Electricity'
    },
  ];

  String _idr(num v) =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
          .format(v);

  String _fmt(String iso) =>
      DateFormat('dd MMM yyyy').format(DateTime.parse(iso));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Name')),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: _transactions.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final t = _transactions[i];
          final isIncome = (t['type'] as String) == 'Income';
          final amount = t['amount'] as num;

          return ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_fmt(t['date'] as String),
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 2),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isIncome ? Colors.green.shade50 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    t['type'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: isIncome
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            title: Text(t['category'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(t['note'] as String,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(
              (isIncome ? '+ ' : '- ') + _idr(amount),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          );
        },
      ),
    );
  }
}
