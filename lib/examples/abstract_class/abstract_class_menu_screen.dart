import 'package:flutter/material.dart';

import 'animal_demo_screen.dart';
import 'app_page_demo_screen.dart';
import 'framework_demo_screen.dart';
import 'repository_demo_screen.dart';

/// Menu chọn từng ví dụ abstract class — mỗi mục một màn riêng.
class AbstractClassMenuScreen extends StatelessWidget {
  const AbstractClassMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abstract Class Lab'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Chọn ví dụ — mỗi màn minh họa một cách dùng abstract class.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _menuTile(
            context,
            icon: Icons.pets,
            title: '1. Animal (Dart)',
            subtitle: 'Animal → Dog / Cat',
            screen: const AnimalDemoScreen(),
          ),
          _menuTile(
            context,
            icon: Icons.storage,
            title: '2. TaskRepository',
            subtitle: 'Abstract + template method',
            screen: const RepositoryDemoScreen(),
          ),
          _menuTile(
            context,
            icon: Icons.web,
            title: '3. AppPage',
            subtitle: 'Giống StatelessWidget.build',
            screen: const AppPageDemoScreen(),
          ),
          _menuTile(
            context,
            icon: Icons.flutter_dash,
            title: '4. Flutter framework',
            subtitle: 'StatelessWidget, State',
            screen: const FrameworkDemoScreen(),
          ),
          const SizedBox(height: 24),
          Text(
            'Doc: md/abstract-class.md',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => screen),
        ),
      ),
    );
  }
}
