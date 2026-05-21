// Màn 3 — Widget hierarchy: BaseCard (abstract) → InfoCard / StatsCard.
// Doc: md/inheritance.md mục 4.3

import 'package:flutter/material.dart';

import 'flutter_widget_inheritance.dart';

class FlutterWidgetDemoScreen extends StatelessWidget {
  const FlutterWidgetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Flutter Widget Inheritance')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _note(context),
          const SizedBox(height: 16),
          const InfoCard(
            title: 'InfoCard extends BaseCard',
            accentColor: Colors.indigo,
            info: 'Lớp con chỉ implement buildContent() — logic build() dùng chung từ cha.',
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 12),
          const StatsCard(
            title: 'StatsCard extends BaseCard',
            accentColor: Colors.teal,
            value: '500',
            unit: 'km range',
          ),
          const SizedBox(height: 12),
          const InfoCard(
            title: 'Thêm một InfoCard khác',
            accentColor: Colors.deepOrange,
            info: 'Cùng một lớp cha, khác instance — tái sử dụng hoàn toàn phần layout.',
            icon: Icons.widgets_outlined,
          ),
          const SizedBox(height: 16),
          Text(
            'File: lib/examples/inheritance/flutter_widget_inheritance.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _note(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: const Text(
        'StatelessWidget → BaseCard → InfoCard / StatsCard\n'
        'BaseCard kế thừa vòng đời widget từ Flutter, '
        'lớp con chỉ cần override buildContent().',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
