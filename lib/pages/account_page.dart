import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AccountPage extends StatelessWidget { const AccountPage({super.key});
  String _idr(num v)=>NumberFormat.currency(locale:'id_ID',symbol:'Rp ',decimalDigits:0).format(v);
  @override Widget build(BuildContext context){
    final accounts=[
      {'title':'Account 1 - Account Number 1','balance':100000,'color':const Color(0xFF43A047)},
      {'title':'Account 2 - Account Number 2','balance':500000,'color':const Color(0xFFFB8C00)},
      {'title':'Account 3 - Account Number 3','balance':1000000,'color':const Color(0xFF8E24AA)},
    ];
    return Scaffold(
      body: ListView(padding: const EdgeInsets.fromLTRB(16,16,16,24), children:[
        SizedBox(height:48, child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1792E8), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: ()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add account tapped (placeholder).'))),
          child: const Text('add account', style: TextStyle(fontWeight: FontWeight.w600)),
        )),
        const SizedBox(height:16),
        for(final a in accounts)...[
          Container(decoration: BoxDecoration(color:a['color'] as Color, borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))]),
            padding: const EdgeInsets.symmetric(horizontal:18, vertical:18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Text(a['title'] as String, style: const TextStyle(color: Colors.white, fontSize:20, fontWeight: FontWeight.w700)),
              const SizedBox(height:8),
              Text('Balance : ${_idr(a['balance'] as num)}', style: const TextStyle(color: Colors.white, fontSize:16)),
            ]),
          ),
          const SizedBox(height:16),
        ]
      ]),
    );
  }
}
