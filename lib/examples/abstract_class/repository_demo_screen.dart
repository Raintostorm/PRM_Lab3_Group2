import 'package:flutter/material.dart';

import 'demo_labels.dart';
import 'task_repository.dart';

/// Màn 2 — UI chỉ biết [TaskRepository] (abstract), không biết implementation.
class RepositoryDemoScreen extends StatefulWidget {
  const RepositoryDemoScreen({super.key});

  @override
  State<RepositoryDemoScreen> createState() => _RepositoryDemoScreenState();
}

class _RepositoryDemoScreenState extends State<RepositoryDemoScreen> {
  late final TaskRepository _repository;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _repository = InMemoryTaskRepository();
    _load();
  }

  Future<void> _load() async {
    final tasks = await _repository.fetchAll();
    if (!mounted) return;
    setState(() => _tasks = tasks);
  }

  Future<void> _toggle(String id) async {
    await _repository.toggleDone(id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. TaskRepository')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DemoLabels.abstractBox('abstract class TaskRepository'),
          const SizedBox(height: 8),
          DemoLabels.concreteBox('class InMemoryTaskRepository extends TaskRepository'),
          const SizedBox(height: 12),
          DemoLabels.typeVsRuntime(
            declaredType: 'TaskRepository',
            runtimeType: _repository.runtimeType.toString(),
          ),
          const SizedBox(height: 8),
          const Text(
            'toggleDone() nằm trên abstract class — persist() do lớp con implement.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          ..._tasks.map(
            (t) => CheckboxListTile(
              value: t.done,
              title: Text(t.title),
              subtitle: Text(t.done ? 'done' : 'pending'),
              onChanged: (_) => _toggle(t.id),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'File: lib/examples/abstract_class/task_repository.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
