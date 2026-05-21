// ============================================================
// INTERFACE DEMO SCREEN — lib/examples/interface/interface_demo_screen.dart
//
// Màn hình tương tác minh họa Interface trong Dart/Flutter.
// Kịch bản: Thanh toán đơn hàng mua sắm online.
//
// Người dùng chọn:
//   1. Phương thức thanh toán (implements PaymentMethod)
//   2. Kênh thông báo (implements NotificationService)
//
// → OrderProcessor xử lý mà KHÔNG CẦN biết implementation cụ thể.
//   Đây là sức mạnh cốt lõi của Interface!
// ============================================================

import 'package:flutter/material.dart';

import 'implementations.dart';
import 'interfaces.dart';
import 'order_processor.dart';

// Danh sách các payment method có sẵn — tất cả đều implements PaymentMethod
final _paymentOptions = <PaymentMethod>[
  CreditCardPayment(),
  BankTransferPayment(),
  EWalletPayment(),
];

// Danh sách các notification channel — tất cả đều implements NotificationService
final _notificationOptions = <NotificationService>[
  EmailNotification(),
  SmsNotification(),
  PushNotification(),
];

class InterfaceDemoScreen extends StatefulWidget {
  const InterfaceDemoScreen({super.key});

  @override
  State<InterfaceDemoScreen> createState() => _InterfaceDemoScreenState();
}

class _InterfaceDemoScreenState extends State<InterfaceDemoScreen> {
  // Lưu lựa chọn của người dùng (kiểu là INTERFACE, không phải implementation)
  PaymentMethod _selectedPayment = _paymentOptions.first;
  NotificationService _selectedNotification = _notificationOptions.first;

  // Trạng thái xử lý
  bool _isProcessing = false;
  OrderResult? _result;

  // Đếm số đơn hàng để tạo orderId
  int _orderCounter = 1;

  Future<void> _processOrder() async {
    setState(() {
      _isProcessing = true;
      _result = null;
    });

    // Tạo OrderProcessor với interface — không cần biết implementation
    final processor = OrderProcessor(
      payment: _selectedPayment,         // bất kỳ PaymentMethod nào
      notification: _selectedNotification, // bất kỳ NotificationService nào
    );

    final orderId = 'ORD-${_orderCounter.toString().padLeft(3, '0')}';
    final result = await processor.processOrder(orderId, 299000);

    setState(() {
      _isProcessing = false;
      _result = result;
      _orderCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interface Demo — Thanh toán'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Giải thích nhanh ──────────────────────────────
          _InterfaceConceptBanner(),
          const SizedBox(height: 16),

          // ── Sản phẩm (đơn hàng demo) ─────────────────────
          _OrderCard(),
          const SizedBox(height: 20),

          // ── Chọn phương thức thanh toán ───────────────────
          _SectionHeader(
            icon: Icons.payment,
            title: 'Chọn phương thức thanh toán',
            subtitle: 'implements PaymentMethod',
            color: Colors.indigo,
          ),
          const SizedBox(height: 8),
          ..._paymentOptions.map(
            (p) => _SelectableCard(
              icon: p.icon,
              title: p.name,
              subtitle: '${p.runtimeType} implements PaymentMethod',
              color: p.color,
              selected: _selectedPayment == p,
              onTap: () => setState(() => _selectedPayment = p),
            ),
          ),
          const SizedBox(height: 20),

          // ── Chọn kênh thông báo ───────────────────────────
          _SectionHeader(
            icon: Icons.notifications,
            title: 'Chọn kênh thông báo',
            subtitle: 'implements NotificationService',
            color: Colors.green,
          ),
          const SizedBox(height: 8),
          ..._notificationOptions.map(
            (n) => _SelectableCard(
              icon: n.channelIcon,
              title: n.channelName,
              subtitle: '${n.runtimeType} implements NotificationService',
              color: Colors.green,
              selected: _selectedNotification == n,
              onTap: () => setState(() => _selectedNotification = n),
            ),
          ),
          const SizedBox(height: 24),

          // ── Nút xử lý ────────────────────────────────────
          _ProcessButton(
            isProcessing: _isProcessing,
            paymentName: _selectedPayment.name,
            notifName: _selectedNotification.channelName,
            onPressed: _isProcessing ? null : _processOrder,
          ),
          const SizedBox(height: 20),

          // ── Kết quả + log bước xử lý ─────────────────────
          if (_result != null) _ResultPanel(result: _result!),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// WIDGETS PHỤ TRỢ
// ─────────────────────────────────────────────────────────────

/// Banner giải thích concept interface ở đầu màn hình.
class _InterfaceConceptBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.info_outline, color: Colors.amber, size: 18),
            const SizedBox(width: 6),
            Text(
              'Điểm mấu chốt của Interface',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ]),
          const SizedBox(height: 6),
          const Text(
            'OrderProcessor chỉ gọi:\n'
            '  _payment.pay()           ← qua interface\n'
            '  _notification.sendConfirmation()  ← qua interface\n\n'
            'Dù bạn chọn thẻ, ví hay chuyển khoản — code xử lý KHÔNG ĐỔI.',
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

/// Card hiển thị thông tin đơn hàng.
class _OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.headphones, color: Colors.orange, size: 28),
        ),
        title: const Text(
          'Tai nghe Bluetooth Pro X',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Số lượng: 1'),
        trailing: const Text(
          '299.000đ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

/// Tiêu đề phần chọn (Payment / Notification).
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
      ]),
    ]);
  }
}

/// Card có thể chọn cho từng payment / notification option.
class _SelectableCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      color: selected ? color.withValues(alpha: 0.07) : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: selected ? color : Colors.grey.shade200,
          child: Icon(icon, color: selected ? Colors.white : Colors.grey),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
        trailing: selected
            ? Icon(Icons.check_circle, color: color)
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}

/// Nút xử lý đơn hàng, hiển thị loader khi đang chạy.
class _ProcessButton extends StatelessWidget {
  final bool isProcessing;
  final String paymentName;
  final String notifName;
  final VoidCallback? onPressed;

  const _ProcessButton({
    required this.isProcessing,
    required this.paymentName,
    required this.notifName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Hiển thị "sẽ dùng" gì trước khi bấm
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'OrderProcessor(\n'
          '  payment: $paymentName,\n'
          '  notification: $notifName,\n'
          ')',
          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: isProcessing
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.shopping_cart_checkout),
          label: Text(
            isProcessing ? 'Đang xử lý...' : 'Thanh toán ngay',
            style: const TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    ]);
  }
}

/// Panel hiển thị kết quả + log từng bước xử lý.
class _ResultPanel extends StatelessWidget {
  final OrderResult result;

  const _ResultPanel({required this.result});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // Header kết quả
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: result.success ? Colors.green.shade50 : Colors.red.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          border: Border.all(
            color: result.success ? Colors.green.shade300 : Colors.red.shade300,
          ),
        ),
        child: Row(children: [
          Icon(
            result.success ? Icons.check_circle : Icons.error,
            color: result.success ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              result.success
                  ? 'Đơn #${result.orderId} hoàn tất'
                  : 'Đơn #${result.orderId} thất bại',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: result.success
                    ? Colors.green.shade800
                    : Colors.red.shade800,
              ),
            ),
          ),
        ]),
      ),

      // Log từng bước — ĐIỂM QUAN TRỌNG: thấy interface được gọi thế nào
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '// Execution log',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 6),
            ...result.logs.map(
              (log) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  log,
                  style: TextStyle(
                    color: log.startsWith('✅') || log.startsWith('🎉')
                        ? Colors.greenAccent
                        : log.startsWith('❌')
                            ? Colors.redAccent
                            : log.contains('Gọi _payment') ||
                                    log.contains('Gọi _notification')
                                ? Colors.yellowAccent
                                : Colors.white70,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Tóm tắt key insight
      if (result.success) ...[
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            '💡 OrderProcessor dùng cùng code cho TẤT CẢ combination\n'
            '   (3 payment × 3 notification = 9 combo) mà không cần if/switch!\n'
            '   Đây là sức mạnh của Interface.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ],
    ]);
  }
}

