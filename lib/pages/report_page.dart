import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pieData = [
      _Slice('Food', 40),
      _Slice('Transport', 25),
      _Slice('Shopping', 20),
      _Slice('Bills', 10),
      _Slice('Other', 5),
    ];

    final monthly = const [ // Jan..Jun demo
      3500000, 2800000, 4200000, 3100000, 3900000, 3600000
    ];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          _CardBox(
            title: 'Spending by Category',
            child: SizedBox(
              height: 260,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: [
                    for (int i=0;i<pieData.length;i++)
                      PieChartSectionData(
                        value: pieData[i].value.toDouble(),
                        title: '${pieData[i].value.toInt()}%',
                        radius: 70,
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
            footer: _PieLegend(items: pieData.map((e) => e.label).toList()),
          ),
          const SizedBox(height: 16),
          _CardBox(
            title: 'Monthly Spending',
            child: SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2000000,
                        getTitlesWidget: (v, m) => Text(NumberFormat.compactCurrency(locale: 'id_ID', symbol: 'Rp ').format(v), style: const TextStyle(fontSize: 10)),
                        reservedSize: 56,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, m) {
                          const months = ['Jan','Feb','Mar','Apr','May','Jun'];
                          final idx = v.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(idx>=0 && idx<months.length ? months[idx] : '', style: const TextStyle(fontSize: 11)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: [
                    for (int i=0;i<monthly.length;i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [BarChartRodData(toY: monthly[i].toDouble(), width: 18, borderRadius: const BorderRadius.vertical(top: Radius.circular(6)))],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slice {
  final String label;
  final num value;
  _Slice(this.label, this.value);
}

class _CardBox extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? footer;
  const _CardBox({required this.title, required this.child, this.footer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        child,
        if (footer != null) ...[ const SizedBox(height: 12), footer! ],
      ]),
    );
  }
}

class _PieLegend extends StatelessWidget {
  final List<String> items;
  const _PieLegend({required this.items});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        for (final label in items)
          Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(3))),
            const SizedBox(width: 6),
            Text(label),
          ]),
      ],
    );
  }
}
