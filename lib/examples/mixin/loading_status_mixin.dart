import 'package:flutter/material.dart';

/// Mixin đặc thù cho UI, giới hạn chỉ được dùng cho các Class là [State].
/// Nhờ từ khóa `on State<T>`, mixin này có quyền truy cập trực tiếp vào `mounted` và `setState`.
mixin LoadingStatusMixin<T extends StatefulWidget> on State<T> {
  // Biến private (có dấu gạch dưới) lưu trạng thái: true là đang bận/loading, false là rảnh
  bool _isLoading = false;

  // Getter để các class bên ngoài có thể đọc được giá trị của biến _isLoading nhưng không thể tự ý sửa nó
  bool get isLoading => _isLoading;

  // Hàm kích hoạt trạng thái Loading (bật vòng xoay)
  void showLoading() {
    // Khuyên dùng: mounted kiểm tra xem Widget này còn hiển thị trên màn hình không trước khi update UI
    if (mounted) {
      // Vì mixin này "on State" nên nó gọi được hàm setState để bắt màn hình vẽ lại (rebuild)
      setState(() {
        _isLoading = true;
      });
    }
  }

  // Hàm tắt trạng thái Loading (tắt vòng xoay, cho user bấm nút lại)
  void hideLoading() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}