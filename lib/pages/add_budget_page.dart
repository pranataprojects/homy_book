import 'package:flutter/material.dart';

class AddBudgetPage extends StatefulWidget {
  const AddBudgetPage({super.key});

  @override
  State<AddBudgetPage> createState() => _AddBudgetPage();
}

class _AddBudgetPage extends State<AddBudgetPage> {
  final List<String> _categories = ['Food', 'Shopping', 'Transportation'];
  String _selectedCategory = "Shopping";

  final List<String> _periods = const ['B08-2025', 'B09-2025', 'B10-2025'];
  final _selectedPeriod = 'B08-2025';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Add Budget Page"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            items: _categories
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (v) => setState(() {
              _selectedCategory = v!;
            }),
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          DropdownButtonFormField<String>(
            initialValue: _selectedPeriod,
            items: _periods
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (v) => setState(() {
              _selectedCategory = v!;
            }),
            decoration: const InputDecoration(
              labelText: 'Period',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: 'Rp ',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
