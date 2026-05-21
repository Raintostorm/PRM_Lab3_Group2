// Màn 1 — Vehicle: minh họa extends, @override, super, is operator.
// Doc: md/inheritance.md mục 4.1

import 'package:flutter/material.dart';

import 'vehicle.dart';

class VehicleDemoScreen extends StatelessWidget {
  const VehicleDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = buildVehicleList();

    return Scaffold(
      appBar: AppBar(title: const Text('1. Vehicle Hierarchy')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _hierarchyChip('Vehicle', Colors.grey),
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 20),
              _hierarchyChip('Car', Colors.blue),
              const SizedBox(width: 8),
              _hierarchyChip('Truck', Colors.orange),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 40),
              _hierarchyChip('ElectricCar', Colors.green),
            ],
          ),
          const SizedBox(height: 20),
          ...list.map((info) => _vehicleCard(context, info)),
          const SizedBox(height: 8),
          Text(
            'File: lib/examples/inheritance/vehicle.dart',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _hierarchyChip(String label, Color color) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _vehicleCard(BuildContext context, VehicleInfo info) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _badge('runtimeType', info.rType, Colors.deepPurple),
                const SizedBox(width: 8),
                if (info.isCar) _badge('is Car', 'true', Colors.blue),
                if (info.isElectric) ...[
                  const SizedBox(width: 8),
                  _badge('is ElectricCar', 'true', Colors.green),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Text(info.describeText),
            const SizedBox(height: 4),
            Text('Fuel: ${info.fuel}',
                style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _badge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        border: Border.all(color: color.withAlpha(100)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12),
          children: [
            TextSpan(text: '$label: ', style: TextStyle(color: Colors.grey.shade700)),
            TextSpan(
              text: value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
