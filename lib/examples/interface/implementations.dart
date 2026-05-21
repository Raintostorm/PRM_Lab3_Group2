// ============================================================
// IMPLEMENTATIONS — lib/examples/interface/implementations.dart
//
// Mỗi class dưới đây dùng `implements` để "ký hợp đồng" với interface.
// Dart BẮT BUỘC override TẤT CẢ method/getter của interface.
// Nếu thiếu 1 method → lỗi compile ngay lập tức.
// ============================================================

import 'package:flutter/material.dart';

import 'interfaces.dart';

// ═══════════════════════════════════════════════════════════
//  PAYMENT IMPLEMENTATIONS — cùng "hợp đồng", khác cách hoạt động
// ═══════════════════════════════════════════════════════════

/// Cổng thanh toán thẻ tín dụng.
/// Từ khóa `implements PaymentMethod` → phải override name, icon, color, pay()
class CreditCardPayment implements PaymentMethod {
  @override
  String get name => 'Thẻ tín dụng / Ghi nợ';

  @override
  IconData get icon => Icons.credit_card;

  @override
  Color get color => Colors.indigo;

  @override
  Future<PaymentResult> pay(double amount) async {
    // Giả lập thời gian xác thực với ngân hàng
    await Future.delayed(const Duration(milliseconds: 900));
    final txnId = 'CC-${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(
      success: true,
      message: 'Ngân hàng xác nhận — thẻ đã được ghi nợ thành công',
      transactionId: txnId,
    );
  }
}

/// Cổng thanh toán chuyển khoản ngân hàng.
class BankTransferPayment implements PaymentMethod {
  @override
  String get name => 'Chuyển khoản ngân hàng';

  @override
  IconData get icon => Icons.account_balance;

  @override
  Color get color => Colors.teal;

  @override
  Future<PaymentResult> pay(double amount) async {
    // Chuyển khoản mất thêm thời gian do qua hệ thống liên ngân hàng
    await Future.delayed(const Duration(milliseconds: 1300));
    final txnId = 'BT-${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(
      success: true,
      message: 'Giao dịch liên ngân hàng thành công — tài khoản đã ghi nợ',
      transactionId: txnId,
    );
  }
}

/// Cổng thanh toán ví điện tử MoMo.
class EWalletPayment implements PaymentMethod {
  @override
  String get name => 'Ví điện tử (MoMo)';

  @override
  IconData get icon => Icons.account_balance_wallet;

  @override
  Color get color => Colors.pink;

  @override
  Future<PaymentResult> pay(double amount) async {
    // Ví điện tử xử lý nhanh nhất vì không qua ngân hàng trung gian
    await Future.delayed(const Duration(milliseconds: 500));
    final txnId = 'EW-${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(
      success: true,
      message: 'MoMo xác nhận — số dư ví đã được trừ thành công',
      transactionId: txnId,
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  NOTIFICATION IMPLEMENTATIONS — cùng "hợp đồng", khác kênh gửi
// ═══════════════════════════════════════════════════════════

/// Gửi thông báo qua Email.
class EmailNotification implements NotificationService {
  @override
  String get channelName => 'Email';

  @override
  IconData get channelIcon => Icons.email_outlined;

  @override
  Future<String> sendConfirmation(String orderId, double amount) async {
    // Giả lập gọi SMTP server (ví dụ: SendGrid, AWS SES)
    await Future.delayed(const Duration(milliseconds: 700));
    return 'Email xác nhận đơn #$orderId đã gửi tới hộp thư của bạn';
  }
}

/// Gửi thông báo qua SMS.
class SmsNotification implements NotificationService {
  @override
  String get channelName => 'SMS';

  @override
  IconData get channelIcon => Icons.sms_outlined;

  @override
  Future<String> sendConfirmation(String orderId, double amount) async {
    // Giả lập gọi SMS gateway (ví dụ: Twilio, VNPT SMS)
    await Future.delayed(const Duration(milliseconds: 400));
    return 'SMS "Đơn #$orderId - ${_fmt(amount)}đ đã thanh toán" đã gửi';
  }

  String _fmt(double v) =>
      v.toInt().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]}.',
      );
}

/// Gửi thông báo qua Push Notification (Firebase FCM).
class PushNotification implements NotificationService {
  @override
  String get channelName => 'Push Notification';

  @override
  IconData get channelIcon => Icons.notifications_outlined;

  @override
  Future<String> sendConfirmation(String orderId, double amount) async {
    // Giả lập gọi Firebase Cloud Messaging
    await Future.delayed(const Duration(milliseconds: 300));
    return 'Push notification đã đẩy tới thiết bị — đơn #$orderId thành công';
  }
}
