import 'package:flutter/material.dart';

class AddInvestmentPage extends StatelessWidget {
  const AddInvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with X (close) and V (save) that both pop back for now
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Cancel',
        ),
        title: const Text('Add Investment Tx'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // mock: just go back for now
              Navigator.pop(context);
            },
            tooltip: 'Save',
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          const Text('Mock Fields',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          // Type
          _FieldCard(
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                  labelText: 'Type', border: OutlineInputBorder()),
              initialValue: 'Top Up',
              items: const [
                DropdownMenuItem(value: 'Top Up', child: Text('Top Up')),
                DropdownMenuItem(value: 'Withdraw', child: Text('Withdraw')),
                DropdownMenuItem(value: 'Profit', child: Text('Profit')),
              ],
              onChanged: (_) {},
            ),
          ),

          const SizedBox(height: 12),

          // Date (mock)
          _FieldCard(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date',
                hintText: '02 Oct 2025',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true, // mock only
              onTap: () {
                // no-op for now (mock)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Date picker (mock)')),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Amount
          _FieldCard(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                hintText: 'Rp 100.000',
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          const SizedBox(height: 12),

          // Note
          _FieldCard(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Note',
                hintText: 'Optional',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            '💡 For now this is only a mock form.\nPress the ✓ or ✕ on the top bar to go back.',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final Widget child;
  const _FieldCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: child,
    );
  }
}
