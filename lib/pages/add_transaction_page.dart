import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key, required this.accounts});

  /// Each: {'id': 'acc1', 'name': 'Account 1 - Account Number 1'}
  final List<Map<String, String>> accounts;

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  // Simple local state (no validation, no persistence)
  String? _accountId;
  String _type = 'Expense'; // Income / Expense / Transfer
  String? _toAccountId;     // only for Transfer
  String? _category;

  final _detailsCtrl = TextEditingController();
  final _amountCtrl  = TextEditingController();
  final _noteCtrl    = TextEditingController();

  DateTime _date = DateTime.now();

  final List<String> _expenseCats = const ['Food', 'Transport', 'Bills', 'Other'];
  final List<String> _incomeCats  = const ['Salary', 'Bonus', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.accounts.isNotEmpty) {
      _accountId = widget.accounts.first['id'];
    }
  }

  @override
  void dispose() {
    _detailsCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label, [String? hint]) => InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      );

  String _fmtDate(DateTime d) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dd = d.day.toString().padLeft(2, '0');
    final mm = months[d.month - 1];
    return '$dd $mm ${d.year}';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final isTransfer = _type == 'Transfer';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        leading: IconButton(
          icon: const Icon(Icons.close), // X = close
          onPressed: () => Navigator.pop(context),
          tooltip: 'Close',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check), // ✓ = save (just go back)
            onPressed: () => Navigator.pop(context),
            tooltip: 'Save',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 1) Account
              DropdownButtonFormField<String>(
                value: _accountId,
                decoration: _dec('Account'),
                items: widget.accounts
                    .map((a) => DropdownMenuItem(
                          value: a['id'],
                          child: Text(a['name'] ?? a['id']!),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _accountId = v),
              ),
              const SizedBox(height: 12),

              // 2) Date
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(8),
                child: InputDecorator(
                  decoration: _dec('Date'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fmtDate(_date)),
                      const Icon(Icons.calendar_today_outlined, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 3) Income / Expense / Transfer
              DropdownButtonFormField<String>(
                value: _type,
                decoration: _dec('Income / Expense / Transfer'),
                items: const ['Income', 'Expense', 'Transfer']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _type = v!;
                  _toAccountId = null;
                  _category = null;
                }),
              ),
              const SizedBox(height: 12),

              // 4) Transfer To (only if Transfer chosen)
              if (isTransfer) ...[
                DropdownButtonFormField<String>(
                  value: _toAccountId,
                  decoration: _dec('Transfer To', '*only if Transfer chosen'),
                  items: widget.accounts
                      .where((a) => a['id'] != _accountId)
                      .map((a) => DropdownMenuItem(
                            value: a['id'],
                            child: Text(a['name'] ?? a['id']!),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _toAccountId = v),
                ),
                const SizedBox(height: 12),
              ],

              // 5) Category (only if Income/Expense chosen)
              if (!isTransfer) ...[
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: _dec('Category', '*depends on Income/Expense'),
                  items: (_type == 'Income' ? _incomeCats : _expenseCats)
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v),
                ),
                const SizedBox(height: 12),
              ],

              // 6) Details
              TextField(
                controller: _detailsCtrl,
                decoration: _dec('Details', '*merchant, bill name, etc.'),
              ),
              const SizedBox(height: 12),

              // 7) Amount (Rp)
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: _dec('Amount', '0').copyWith(
                  prefixText: 'Rp ',
                  prefixStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 12),                

              // 8) Note
              TextField(
                controller: _noteCtrl,
                decoration: _dec('Note'),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

