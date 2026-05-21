// Ví dụ 3 — Inheritance trong Flutter framework: custom widget hierarchy.
// Doc: md/inheritance.md mục 4.3

import 'package:flutter/material.dart';

// BaseCard extends StatelessWidget — kế thừa toàn bộ vòng đời widget.
// buildContent() là hook để lớp con chèn nội dung riêng.
abstract class BaseCard extends StatelessWidget {
  final String title;
  final Color accentColor;

  const BaseCard({super.key, required this.title, required this.accentColor});

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: accentColor,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: buildContent(context),
          ),
        ],
      ),
    );
  }
}

// InfoCard — lớp con thêm icon + mô tả.
class InfoCard extends BaseCard {
  final String info;
  final IconData icon;

  const InfoCard({
    super.key,
    required super.title,
    required super.accentColor,
    required this.info,
    required this.icon,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: accentColor),
        const SizedBox(width: 8),
        Expanded(child: Text(info)),
      ],
    );
  }
}

// StatsCard — lớp con hiển thị số liệu lớn.
class StatsCard extends BaseCard {
  final String value;
  final String unit;

  const StatsCard({
    super.key,
    required super.title,
    required super.accentColor,
    required this.value,
    required this.unit,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(unit, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
