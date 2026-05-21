// Menu điều hướng các ví dụ Inheritance.
// Doc: md/inheritance.md

import 'package:flutter/material.dart';

import 'flutter_widget_demo_screen.dart';
import 'shape_demo_screen.dart';
import 'vehicle_demo_screen.dart';

class InheritanceMenuScreen extends StatelessWidget {
  const InheritanceMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inheritance Lab'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Chọn ví dụ — mỗi màn minh họa một khía cạnh của inheritance.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _menuTile(
            context,
            icon: Icons.directions_car,
            title: '1. Vehicle Hierarchy',
            subtitle: 'Vehicle → Car → ElectricCar / Truck\nextends, @override, super, is',
            screen: const VehicleDemoScreen(),
          ),
          _menuTile(
            context,
            icon: Icons.crop_square,
            title: '2. Shape — Multi-level',
            subtitle: 'Shape → Polygon → Rectangle → Square\nconstructor chaining qua nhiều tầng',
            screen: const ShapeDemoScreen(),
          ),
          _menuTile(
            context,
            icon: Icons.widgets,
            title: '3. Flutter Widget Inheritance',
            subtitle: 'StatelessWidget → BaseCard → InfoCard / StatsCard\ntái sử dụng layout qua kế thừa',
            screen: const FlutterWidgetDemoScreen(),
          ),
          const SizedBox(height: 24),
          Text(
            'Doc: md/inheritance.md',
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
        isThreeLine: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => screen),
        ),
      ),
    );
  }
}
