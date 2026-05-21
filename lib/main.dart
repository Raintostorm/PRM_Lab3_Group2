import 'package:flutter/material.dart';

import 'examples/abstract_class/abstract_class_menu_screen.dart';
import 'examples/interface/interface_menu_screen.dart';
import 'examples/mixin/mixin_demo.dart';

void main() {
  runApp(const PrmLab3App());
}

/// Entry app — [StatelessWidget] là abstract class từ Flutter framework.
class PrmLab3App extends StatelessWidget {
  const PrmLab3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRM Lab3 — OOP Concepts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Màn hình chính
      home: const HomeScreen(),
    );
  }
}

/// Home Screen chứa các phần demo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter OOP Demo"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            /// Abstract Class Demo
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AbstractClassMenuScreen(),
                  ),
                );
              },
              child: const Text("Abstract Class Demo"),
            ),

            const SizedBox(height: 20),

            /// Mixin Demo
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MixinExampleScreen(),
                  ),
                );
              },
              child: const Text("Mixin Demo"),
            ),

            const SizedBox(height: 20),

            /// Interface Demo
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InterfaceMenuScreen(),
                  ),
                );
              },
              child: const Text("Interface Demo"),
            ),
          ],
        ),
      ),
    );
  }
}