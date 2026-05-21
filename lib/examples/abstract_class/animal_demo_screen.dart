import 'package:flutter/material.dart';

import 'animal.dart';
import 'demo_labels.dart';

/// Màn 1 — Animal: biến kiểu abstract, object lớp con cụ thể.
class AnimalDemoScreen extends StatelessWidget {
  const AnimalDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = <Animal>[Dog('Buddy'), Cat('Mimi')];

    return Scaffold(
      appBar: AppBar(title: const Text('1. Animal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DemoLabels.abstractBox('abstract class Animal'),
          const SizedBox(height: 8),
          DemoLabels.concreteBox('class Dog extends Animal'),
          const SizedBox(height: 4),
          DemoLabels.concreteBox('class Cat extends Animal'),
          const SizedBox(height: 20),
          ...pets.map((pet) => _petCard(pet)),
          const SizedBox(height: 12),
          Text(
            'File: lib/examples/abstract_class/animal.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _petCard(Animal pet) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DemoLabels.typeVsRuntime(
              declaredType: 'Animal',
              runtimeType: pet.runtimeType.toString(),
            ),
            const SizedBox(height: 12),
            Text(pet.speak(), style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
              pet.breathe(),
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
