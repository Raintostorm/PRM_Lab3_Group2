// ============================================================
// INTERFACE DEFINITIONS — lib/examples/interface/interfaces.dart
//
// Trong Dart, KHÔNG có từ khóa 'interface' riêng như Java/C#.
// Ta dùng abstract class với toàn bộ là abstract method (không có
// implementation) — đó chính là Interface trong Dart.
//
// Từ khóa quan trọng: `implements` (KHÔNG phải `extends`)
//   - `extends`   → kế thừa cả code lẫn "hợp đồng"
//   - `implements` → chỉ kế thừa "hợp đồng", buộc phải viết lại TẤT CẢ
// ============================================================

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// INTERFACE 1: PaymentMethod — "Hợp đồng" cho mọi cổng thanh toán
// ─────────────────────────────────────────────────────────────
abstract class PaymentMethod {
  // Tên hiển thị (ví dụ: "Thẻ tín dụng", "Ví MoMo")
  String get name;

  // Icon & màu dùng trên UI
  IconData get icon;
  Color get color;

  // Phương thức thanh toán — PHẢI được implement bởi mọi lớp con.
  // Trả về [PaymentResult] gồm trạng thái + mã giao dịch.
  Future<PaymentResult> pay(double amount);
}

// ─────────────────────────────────────────────────────────────
// INTERFACE 2: NotificationService — "Hợp đồng" cho mọi kênh thông báo
// ─────────────────────────────────────────────────────────────
abstract class NotificationService {
  // Tên kênh (ví dụ: "Email", "SMS")
  String get channelName;

  // Icon kênh dùng trên UI
  IconData get channelIcon;

  // Gửi xác nhận đơn hàng — PHẢI được implement bởi mọi lớp con.
  // Trả về chuỗi mô tả kết quả gửi.
  Future<String> sendConfirmation(String orderId, double amount);
}

// ─────────────────────────────────────────────────────────────
// DATA CLASSES — kết quả trả về (không phải interface)
// ─────────────────────────────────────────────────────────────

/// Kết quả sau khi gọi PaymentMethod.pay()
class PaymentResult {
  final bool success;
  final String message;
  final String transactionId;

  const PaymentResult({
    required this.success,
    required this.message,
    required this.transactionId,
  });
}

/// Kết quả tổng hợp sau khi OrderProcessor xử lý xong
class OrderResult {
  final bool success;
  final String orderId;
  final String paymentMethod;
  final String notificationChannel;
  final String transactionId;
  final String paymentMessage;
  final String notificationMessage;
  final List<String> logs; // Các bước đã thực hiện (hiển thị lên UI)

  const OrderResult({
    required this.success,
    required this.orderId,
    required this.paymentMethod,
    required this.notificationChannel,
    required this.transactionId,
    required this.paymentMessage,
    required this.notificationMessage,
    required this.logs,
  });
}
