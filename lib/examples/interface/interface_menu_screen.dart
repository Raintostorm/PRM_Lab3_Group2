// ============================================================
// INTERFACE MENU SCREEN — lib/examples/interface/interface_menu_screen.dart
// ============================================================

import 'package:flutter/material.dart';

import 'interface_demo_screen.dart';

class InterfaceMenuScreen extends StatelessWidget {
  const InterfaceMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interface Lab'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Tóm tắt lý thuyết ────────────────────────────
          _theoryCard(),
          const SizedBox(height: 16),

          Text(
            'Chọn demo bên dưới để xem interface hoạt động:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),

          // ── Demo chính: Thanh toán đơn hàng ─────────────
          _menuTile(
            context,
            icon: Icons.shopping_cart,
            iconColor: Colors.deepPurple,
            title: '1. Hệ thống thanh toán',
            subtitle: 'PaymentMethod + NotificationService interface\n'
                'OrderProcessor dùng Dependency Injection',
            screen: const InterfaceDemoScreen(),
          ),

          const SizedBox(height: 24),

          // ── Chú thích file ────────────────────────────────
          Text(
            'Files:\n'
            '  lib/examples/interface/interfaces.dart\n'
            '  lib/examples/interface/implementations.dart\n'
            '  lib/examples/interface/order_processor.dart',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
          ),
        ],
      ),
    );
  }

  /// Card tóm tắt lý thuyết interface.
  Widget _theoryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.school, color: Colors.deepPurple.shade400, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Interface trong Dart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          const SizedBox(height: 8),
          const Text(
            'Dart không có từ khóa "interface".\n'
            'Dùng abstract class + implements để tạo interface:\n',
            style: TextStyle(fontSize: 13),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '// Định nghĩa interface\n'
              'abstract class PaymentMethod {\n'
              '  String get name;\n'
              '  Future<Result> pay(double amount);\n'
              '}\n\n'
              '// Triển khai interface\n'
              'class CreditCard implements PaymentMethod {\n'
              '  @override String get name => "Thẻ tín dụng";\n'
              '  @override Future<Result> pay(double a) async { ... }\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '• extends   → kế thừa code + hợp đồng\n'
            '• implements → chỉ hợp đồng, bắt buộc viết lại tất cả',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => screen),
        ),
      ),
    );
  }
}
