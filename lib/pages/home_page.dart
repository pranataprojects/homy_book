import 'package:flutter/material.dart';
import 'account_page.dart';
import 'budget_page.dart';
import 'report_page.dart';
import 'investment_page.dart';
import 'goal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 0;
  static const Color navy = Color(0xFF0D2A50);
  final pages = const [AccountPage(), BudgetPage(), ReportPage(), InvestmentPage(), GoalPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          CircleAvatar(radius: 12, backgroundColor: Colors.white30, child: Icon(Icons.star, size: 16, color: Colors.white)),
          SizedBox(width: 8),
          Text('HOMY BOOK', style: TextStyle(fontWeight: FontWeight.w700)),
        ]),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.settings), onPressed: ()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings tapped (placeholder).'))))],
      ),
      body: IndexedStack(index: i, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 64,
        selectedIndex: i,
        onDestinationSelected: (v)=>setState(()=>i=v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), selectedIcon: Icon(Icons.account_balance_wallet), label: 'Account'),
          NavigationDestination(icon: Icon(Icons.pie_chart_outline), selectedIcon: Icon(Icons.pie_chart), label: 'Budget'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Report'),
          NavigationDestination(icon: Icon(Icons.trending_up_outlined), selectedIcon: Icon(Icons.trending_up), label: 'Invest'),
          NavigationDestination(icon: Icon(Icons.flag_outlined), selectedIcon: Icon(Icons.flag), label: 'Goal'),
        ],
      ),
    );
  }
}
