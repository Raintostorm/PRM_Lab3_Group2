import 'package:flutter/material.dart';

import 'examples/abstract_class/abstract_class_menu_screen.dart';

void main() {
  runApp(const PrmLab3App());
}

/// Entry app — [StatelessWidget] là abstract class từ Flutter framework.
class PrmLab3App extends StatelessWidget {
  const PrmLab3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRM Lab3 — Abstract Class',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AbstractClassMenuScreen(),
    );
  }
}
