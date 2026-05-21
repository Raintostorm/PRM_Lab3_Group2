// Màn 2 — Shape: minh họa multi-level inheritance và constructor chaining.
// Doc: md/inheritance.md mục 4.2

import 'package:flutter/material.dart';

import 'shape.dart';

class ShapeDemoScreen extends StatelessWidget {
  const ShapeDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shapes = buildShapeList();

    return Scaffold(
      appBar: AppBar(title: const Text('2. Shape — Multi-level')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _chainLabel(context),
          const SizedBox(height: 16),
          ...shapes.map((s) => _shapeCard(context, s)),
          const SizedBox(height: 8),
          Text(
            'File: lib/examples/inheritance/shape.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _chainLabel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: const Text(
        'Shape  →  Polygon (sides)  →  Rectangle (w×h)  →  Square (side)',
        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
      ),
    );
  }

  Widget _shapeCard(BuildContext context, Shape shape) {
    final isSquare = shape is Square;
    final isRect = shape is Rectangle;
    final isPoly = shape is Polygon;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shape.runtimeType.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                if (isPoly) _typeChip('is Polygon', Colors.teal),
                if (isRect) _typeChip('is Rectangle', Colors.indigo),
                if (isSquare) _typeChip('is Square', Colors.purple),
                _typeChip('is Shape', Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            Text(shape.describe(), style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _typeChip(String label, Color color) {
    return Chip(
      label: Text(label, style: TextStyle(color: color, fontSize: 11)),
      backgroundColor: color.withAlpha(20),
      side: BorderSide(color: color.withAlpha(80)),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
