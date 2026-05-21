import 'package:flutter/material.dart';

/// Nhãn trực quan dùng chung cho các màn demo abstract class.
class DemoLabels {
  static Widget abstractBox(String code) {
    return _typeBox(
      label: 'ABSTRACT',
      code: code,
      color: Colors.orange.shade100,
      border: Colors.orange.shade700,
      icon: Icons.lock_outline,
      hint: 'Không tạo instance trực tiếp',
    );
  }

  static Widget concreteBox(String code) {
    return _typeBox(
      label: 'CONCRETE',
      code: code,
      color: Colors.green.shade50,
      border: Colors.green.shade700,
      icon: Icons.check_circle_outline,
      hint: 'Có thể tạo instance',
    );
  }

  static Widget typeVsRuntime({
    required String declaredType,
    required String runtimeType,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          children: [
            const TextSpan(
              text: 'Biến: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: declaredType,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: '  →  '),
            const TextSpan(
              text: 'Thực tế: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: runtimeType,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _typeBox({
    required String label,
    required String code,
    required Color color,
    required Color border,
    required IconData icon,
    required String hint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: border),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: border,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            hint,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
