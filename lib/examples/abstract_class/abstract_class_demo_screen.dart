import 'package:flutter/material.dart';

import 'animal.dart';
import 'app_page.dart';
import 'framework_note.dart';
import 'task_repository.dart';

/// Màn hình demo gộp 4 ví dụ abstract class — chạy từ [main.dart].
class AbstractClassDemoScreen extends StatefulWidget {
  const AbstractClassDemoScreen({super.key});

  @override
  State<AbstractClassDemoScreen> createState() => _AbstractClassDemoScreenState();
}

class _AbstractClassDemoScreenState extends State<AbstractClassDemoScreen> {
  late final TaskRepository _repository;
  List<Task> _tasks = [];
  int _pageIndex = 0;

  final _pages = <AppPage>[HomePage(), AboutPage()];

  @override
  void initState() {
    super.initState();
    _repository = InMemoryTaskRepository();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _repository.fetchAll();
    if (!mounted) return;
    setState(() => _tasks = tasks);
  }

  Future<void> _toggleTask(String id) async {
    await _repository.toggleDone(id);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abstract Class Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            title: '1. Dart — Animal (abstract)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: runAnimalDemo()
                  .map((line) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(line),
                      ))
                  .toList(),
            ),
          ),
          _section(
            title: '2. Repository — TaskRepository (abstract)',
            child: Column(
              children: _tasks
                  .map(
                    (t) => CheckboxListTile(
                      value: t.done,
                      title: Text(t.title),
                      onChanged: (_) => _toggleTask(t.id),
                    ),
                  )
                  .toList(),
            ),
          ),
          _section(
            title: '3. UI pattern — AppPage (abstract + build)',
            child: Column(
              children: [
                SegmentedButton<int>(
                  segments: [
                    for (var i = 0; i < _pages.length; i++)
                      ButtonSegment<int>(
                        value: i,
                        label: Text(_pages[i].title),
                      ),
                  ],
                  selected: {_pageIndex},
                  onSelectionChanged: (s) =>
                      setState(() => _pageIndex = s.first),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: AppPageHost(page: _pages[_pageIndex]),
                ),
              ],
            ),
          ),
          _section(
            title: '4. Flutter framework',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: frameworkAbstractClassNotes()
                  .map((n) => ListTile(
                        dense: true,
                        leading: const Icon(Icons.info_outline, size: 20),
                        title: Text(n),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'File: lib/examples/abstract_class/*.dart\nDoc: md/abstract-class.md',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}
