// Ví dụ 2 — Abstract class repository. Doc: md/abstract-class.md mục 6.2

class Task {
  const Task({required this.id, required this.title, this.done = false});

  final String id;
  final String title;
  final bool done;

  Task copyWith({bool? done}) =>
      Task(id: id, title: title, done: done ?? this.done);
}

abstract class TaskRepository {
  Future<List<Task>> fetchAll();

  /// Concrete method — template: luôn gọi [persist] sau khi đổi dữ liệu.
  Future<void> toggleDone(String id) async {
    final tasks = (await fetchAll()).toList();
    final index = tasks.indexWhere((t) => t.id == id);
    if (index < 0) return;
    final updated = tasks[index].copyWith(done: !tasks[index].done);
    tasks[index] = updated;
    await persist(tasks);
  }

  Future<void> persist(List<Task> tasks);
}

class InMemoryTaskRepository extends TaskRepository {
  InMemoryTaskRepository()
      : _tasks = [
          const Task(id: '1', title: 'Học abstract class'),
          const Task(id: '2', title: 'Push lên GitHub'),
        ];

  final List<Task> _tasks;

  @override
  Future<List<Task>> fetchAll() async =>
      List<Task>.unmodifiable(_tasks);

  @override
  Future<void> persist(List<Task> tasks) async {
    _tasks
      ..clear()
      ..addAll(tasks);
  }
}
