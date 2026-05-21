import 'package:flutter/material.dart';

import 'app_page.dart';
import 'demo_labels.dart';

/// Màn 3 — AppPage mô phỏng abstract build() như StatelessWidget.
class AppPageDemoScreen extends StatefulWidget {
  const AppPageDemoScreen({super.key});

  @override
  State<AppPageDemoScreen> createState() => _AppPageDemoScreenState();
}

class _AppPageDemoScreenState extends State<AppPageDemoScreen> {
  int _index = 0;
  final _pages = <AppPage>[HomePage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    final page = _pages[_index];

    return Scaffold(
      appBar: AppBar(title: const Text('3. AppPage')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DemoLabels.abstractBox('abstract class AppPage'),
          const SizedBox(height: 8),
          DemoLabels.concreteBox('class HomePage extends AppPage'),
          const SizedBox(height: 4),
          DemoLabels.concreteBox('class AboutPage extends AppPage'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Tương tự Flutter:\n'
              'abstract StatelessWidget → override build()\n'
              'abstract AppPage → override build()',
              style: TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          DemoLabels.typeVsRuntime(
            declaredType: 'AppPage',
            runtimeType: page.runtimeType.toString(),
          ),
          const SizedBox(height: 12),
          SegmentedButton<int>(
            segments: [
              for (var i = 0; i < _pages.length; i++)
                ButtonSegment(value: i, label: Text(_pages[i].title)),
            ],
            selected: {_index},
            onSelectionChanged: (s) => setState(() => _index = s.first),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppPageHost(page: page),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'File: lib/examples/abstract_class/app_page.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
