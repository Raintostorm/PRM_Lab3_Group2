import 'package:flutter/material.dart';

import 'demo_labels.dart';
import 'framework_note.dart';

/// Màn 4 — Abstract class có sẵn trong Flutter (StatelessWidget, State).
class FrameworkDemoScreen extends StatelessWidget {
  const FrameworkDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Flutter framework')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DemoLabels.abstractBox('abstract class StatelessWidget'),
          const SizedBox(height: 8),
          DemoLabels.concreteBox('class PrmLab3App extends StatelessWidget'),
          const SizedBox(height: 12),
          DemoLabels.typeVsRuntime(
            declaredType: 'StatelessWidget',
            runtimeType: 'PrmLab3App',
          ),
          const SizedBox(height: 16),
          ...frameworkAbstractClassNotes().map(
            (note) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(note, style: const TextStyle(fontSize: 14)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'main.dart: PrmLab3App extends StatelessWidget → @override build()',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
