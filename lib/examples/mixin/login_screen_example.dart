import 'package:flutter/material.dart';
import 'auth_validation_mixin.dart';
import 'loading_status_mixin.dart';

// Khai báo một StatefulWidget như thông thường
class LoginScreenExample extends StatefulWidget {
  const LoginScreenExample({super.key});

  @override
  State<LoginScreenExample> createState() => _LoginScreenExampleState();
}

/// Class State sử dụng đa Mixin thông qua từ khóa `with`.
/// Class này vừa có khả năng Validate, vừa tự có Logic Loading mà không cần khai báo lại biến.
class _LoginScreenExampleState extends State<LoginScreenExample>
    with AuthValidationMixin, LoadingStatusMixin { // <--- Tích hợp 2 mảnh ghép vào đây

  // Chìa khóa quản lý trạng thái Form (để kích hoạt trigger validate toàn bộ ô nhập)
  final _formKey = GlobalKey<FormState>();

  // Bộ điều khiển để lấy dữ liệu chữ từ ô nhập Email và Password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Hàm hủy giải phóng bộ nhớ khi thoát màn hình (tránh rò rỉ bộ nhớ - memory leak)
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm xử lý sự kiện khi bấm nút Đăng nhập
  Future<void> _submitLogin() async {
    // 1. Lệnh này sẽ chạy qua tất cả các hàm `validator` ở các ô nhập liệu phía dưới
    if (_formKey.currentState!.validate()) {

      // 2. Nếu thông tin chuẩn hết, gọi hàm showLoading() lấy từ LoadingStatusMixin để hiện vòng xoay
      showLoading();

      // 3. Giả lập một tác vụ tốn thời gian (như đợi Server phản hồi trong 2 giây)
      await Future.delayed(const Duration(seconds: 2));

      // 4. Sau khi kết nối xong, gọi hàm hideLoading() từ LoadingStatusMixin để tắt vòng xoay
      hideLoading();

      // 5. Nếu màn hình vẫn hiển thị thì thông báo cho người dùng biết thành công
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập thành công!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mixin Architecture Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Gắn chìa khóa Form vào đây
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ô nhập liệu Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),

                // KẾT QUẢ MIXIN 1: Gọi trực tiếp hàm kiểm tra email từ AuthValidationMixin
                validator: validateEmail,

                // KẾT QUẢ MIXIN 2: Sử dụng biến isLoading từ LoadingStatusMixin để khóa ô nhập khi đang load
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),

              // Ô nhập liệu Mật khẩu
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true, // Ẩn mật khẩu thành dấu chấm thành dạng mật mã

                // KẾT QUẢ MIXIN 1: Gọi trực tiếp hàm kiểm tra password từ AuthValidationMixin
                validator: validatePassword,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              // KẾT QUẢ MIXIN 2: Kiểm tra biến isLoading để hoán đổi UI linh hoạt
              isLoading
                  ? const CircularProgressIndicator() // Nếu đang load -> Hiện vòng tròn xoay xoay
                  : ElevatedButton(                  // Nếu không load -> Hiện nút bấm đăng nhập bình thường
                onPressed: _submitLogin,
                child: const Text('Đăng nhập'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}