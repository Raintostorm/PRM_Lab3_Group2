/// Mixin độc lập, chịu trách nhiệm xử lý các logic xác thực dữ liệu đầu vào.
/// Có thể tái sử dụng ở bất kỳ đâu (Controllers, Services, Widgets).
mixin AuthValidationMixin {

  // Hàm kiểm tra Email nhập vào có hợp lệ không
  String? validateEmail(String? value) {
    // Nếu user chưa nhập gì hoặc để trống -> báo lỗi
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }

    // Biểu thức chính quy (RegExp) để bắt đúng cấu trúc chữ@chữ.chữ (định dạng email)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Nếu email nhập vào không khớp với định dạng chuẩn -> báo lỗi
    if (!emailRegex.hasMatch(value)) {
      return 'Định dạng email không hợp lệ';
    }

    // Trả về null nghĩa là dữ liệu hoàn toàn hợp lệ, không có lỗi
    return null;
  }

  // Hàm kiểm tra Mật khẩu nhập vào
  String? validatePassword(String? value) {
    // Nếu để trống -> báo lỗi
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }

    // Ép buộc mật khẩu phải dài một chút để bảo mật
    if (value.length < 6) {
      return 'Mật khẩu phải chứa ít nhất 6 ký tự';
    }
    return null;
  }
}