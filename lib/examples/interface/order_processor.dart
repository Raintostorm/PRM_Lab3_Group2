// ============================================================
// ORDER PROCESSOR — lib/examples/interface/order_processor.dart
//
// Đây là trái tim của demo: OrderProcessor KHÔNG biết implementation
// cụ thể nào được dùng. Nó chỉ biết interface.
//
// Kỹ thuật này gọi là DEPENDENCY INJECTION (DI):
//   → "Tiêm" implementation từ bên ngoài vào thay vì tạo trong constructor.
//   → OrderProcessor trở nên linh hoạt, dễ test, dễ thay thế.
// ============================================================

import 'interfaces.dart';

class OrderProcessor {
  // Khai báo kiểu là INTERFACE — không phải CreditCardPayment hay BankTransferPayment
  final PaymentMethod _payment;
  final NotificationService _notification;

  // Constructor nhận bất kỳ class nào implements PaymentMethod / NotificationService
  const OrderProcessor({
    required PaymentMethod payment,
    required NotificationService notification,
  })  : _payment = payment,
        _notification = notification;

  /// Xử lý đơn hàng theo 4 bước — trả về log từng bước để hiển thị trên UI.
  Future<OrderResult> processOrder(String orderId, double amount) async {
    final logs = <String>[];

    // BƯỚC 1: Bắt đầu xử lý
    logs.add('🛒  Bắt đầu xử lý đơn hàng #$orderId');
    logs.add('💰  Số tiền: ${_formatMoney(amount)}đ');
    await Future.delayed(const Duration(milliseconds: 200));

    // BƯỚC 2: Gọi payment.pay() qua INTERFACE
    // OrderProcessor không biết đây là thẻ, ví hay chuyển khoản!
    logs.add('💳  Gọi _payment.pay() → [${_payment.name}]');
    final result = await _payment.pay(amount);

    if (!result.success) {
      logs.add('❌  Thanh toán thất bại: ${result.message}');
      return OrderResult(
        success: false,
        orderId: orderId,
        paymentMethod: _payment.name,
        notificationChannel: _notification.channelName,
        transactionId: '',
        paymentMessage: result.message,
        notificationMessage: '',
        logs: logs,
      );
    }

    logs.add('✅  Thanh toán thành công');
    logs.add('🔑  Mã giao dịch: ${result.transactionId}');
    await Future.delayed(const Duration(milliseconds: 150));

    // BƯỚC 3: Gọi notification.sendConfirmation() qua INTERFACE
    // OrderProcessor không biết đây là Email, SMS hay Push!
    logs.add('📨  Gọi _notification.sendConfirmation() → [${_notification.channelName}]');
    final notifMessage = await _notification.sendConfirmation(orderId, amount);
    logs.add('✅  $notifMessage');
    await Future.delayed(const Duration(milliseconds: 100));

    // BƯỚC 4: Hoàn tất
    logs.add('🎉  Đơn hàng #$orderId hoàn tất!');

    return OrderResult(
      success: true,
      orderId: orderId,
      paymentMethod: _payment.name,
      notificationChannel: _notification.channelName,
      transactionId: result.transactionId,
      paymentMessage: result.message,
      notificationMessage: notifMessage,
      logs: logs,
    );
  }

  String _formatMoney(double v) =>
      v.toInt().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
      );
}
