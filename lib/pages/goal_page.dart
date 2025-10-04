import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoalPage extends StatelessWidget {
  const GoalPage({super.key});
  String _idr(num v) =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
          .format(v);
  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'title': 'Emergency Fund',
        'icon': Icons.savings,
        'color': const Color(0xFF6EC1BD),
        'balance': 7500000,
        'target': 50000000
      },
      {
        'title': 'Vehicle',
        'icon': Icons.directions_car_rounded,
        'color': const Color(0xFF9D84CF),
        'balance': 5000000,
        'target': 100000000
      },
      {
        'title': 'Vacation',
        'icon': Icons.flight,
        'color': const Color(0xFFB8C7E8),
        'balance': 1000000,
        'target': 20000000
      },
    ];
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            for (final g in goals) ...[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ],
                    border: Border.all(color: Color(0xFFE0E0E0))),
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            radius: 22,
                            backgroundColor: (g['color'] as Color),
                            child: Icon(g['icon'] as IconData,
                                color: Colors.black54)),
                        const SizedBox(width: 12),
                        Text(g['title'] as String,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ]),
                      const SizedBox(height: 12),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                              value:
                                  ((g['balance'] as num) / (g['target'] as num))
                                      .clamp(0, 1),
                              minHeight: 8,
                              backgroundColor: const Color(0xFFE3F2FD),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF90CAF9)))),
                      const SizedBox(height: 10),
                      Text('Your balance: ${_idr(g['balance'] as num)}',
                          style: const TextStyle(fontSize: 16)),
                      Text('Target: ${_idr(g['target'] as num)}',
                          style: const TextStyle(fontSize: 16)),
                    ]),
              ),
              const SizedBox(height: 16),
            ]
          ]),
    );
  }
}
