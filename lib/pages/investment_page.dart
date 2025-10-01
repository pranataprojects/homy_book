import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class InvestmentPage extends StatelessWidget{ const InvestmentPage({super.key});
  String _idr(num v)=>NumberFormat.currency(locale:'id_ID',symbol:'Rp ',decimalDigits:0).format(v);
  @override Widget build(BuildContext context){
    final data=[
      {'title':'Emergency Fund','target':1000000,'items':{'A':100000,'B':200000}},
      {'title':'Vehicle','target':100000000,'items':{'A':1000000,'B':500000}},
    ];
    return Scaffold(
      body: ListView(padding: const EdgeInsets.fromLTRB(16,20,16,24), children:[
        const Padding(padding: EdgeInsets.only(bottom:12, left:4), child: Text('Investment', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))),
        for(final m in data)...[
          Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))], border: Border.all(color: Color(0xFFE0E0E0))),
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Row(children:[
                Expanded(child: Text(m['title'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700))),
                Text('Total : ${_idr((m['items'] as Map<String,num>).values.reduce((a,b)=>a+b))}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height:8),
              Text('Target : ${_idr(m['target'] as num)}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height:12),
              for(final e in (m['items'] as Map<String,num>).entries)
                Padding(padding: const EdgeInsets.only(bottom:4), child: Text('${e.key} : ${_idr(e.value)}', style: const TextStyle(fontSize: 16))),
            ]),
          ),
          const SizedBox(height:16),
        ]
      ]),
    );
  }
}
