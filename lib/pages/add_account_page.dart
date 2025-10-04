import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _initialValueController = TextEditingController();

  // Type
  final List<String> _types = ['Bank', 'Savings', 'E-money', 'Cash'];
  String _selectedType = 'Bank';

  // Color (labeled options to avoid overflow)
  final List<Map<String, dynamic>> _colorOptions = const [
    {'label': 'Orange', 'color': Colors.orange},
    {'label': 'Green', 'color': Colors.green},
    {'label': 'Blue', 'color': Colors.blue},
    {'label': 'Purple', 'color': Colors.purple},
  ];
  Color _selectedColor = Colors.orange;

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _initialValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('New account'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // UI only for now
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account name
          TextField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Account name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Bank account number
          TextField(
            controller: _numberController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Bank account number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // Type dropdown
          DropdownButtonFormField<String>(
            value: _selectedType,
            isExpanded: true,
            items: _types
                .map((t) => DropdownMenuItem<String>(
                      value: t,
                      child: Text(t),
                    ))
                .toList(),
            onChanged: (val) =>
                setState(() => _selectedType = val ?? _selectedType),
            decoration: const InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Initial value
          TextField(
            controller: _initialValueController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: 'Initial value',
              prefixText: 'Rp ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Color dropdown (no overflow)
          DropdownButtonFormField<Color>(
            value: _selectedColor,
            isExpanded: true,
            items: _colorOptions.map((opt) {
              final c = opt['color'] as Color;
              final label = opt['label'] as String;
              return DropdownMenuItem<Color>(
                value: c,
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration:
                          BoxDecoration(color: c, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(label, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) =>
                setState(() => _selectedColor = val ?? _selectedColor),
            decoration: const InputDecoration(
              labelText: 'Color',
              border: OutlineInputBorder(),
            ),
            // Makes the closed field show swatch + label too
            selectedItemBuilder: (context) => _colorOptions.map((opt) {
              final c = opt['color'] as Color;
              final label = opt['label'] as String;
              return Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Text(label),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
