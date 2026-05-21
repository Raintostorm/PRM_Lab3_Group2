import 'package:flutter/material.dart';

/// Mixin dùng để chia sẻ chức năng log
mixin Logger {

  // Method log dùng chung cho nhiều class
  void log(String message) {
    print("LOG: $message");
  }
}

/// Class Student sử dụng Logger mixin
class Student with Logger {

  // Method study()
  String study() {

    // Gọi method log từ mixin
    log("Student is studying");

    return "Student is studying";
  }
}

/// Class Teacher sử dụng Logger mixin
class Teacher with Logger {

  // Method teach()
  String teach() {

    // Gọi method log từ mixin
    log("Teacher is teaching");

    return "Teacher is teaching";
  }
}

/// Widget giao diện chính
class MixinExampleScreen extends StatefulWidget {
  const MixinExampleScreen({super.key});

  @override
  State<MixinExampleScreen> createState() =>
      _MixinExampleScreenState();
}

class _MixinExampleScreenState
    extends State<MixinExampleScreen> {

  // Tạo object Student
  final Student student = Student();

  // Tạo object Teacher
  final Teacher teacher = Teacher();

  // Biến lưu kết quả hiển thị
  String message = "Press a button";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Mixin Example"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Hiển thị kết quả trên màn hình
            Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            // Button cho Student
            ElevatedButton(
              onPressed: () {

                // Cập nhật UI
                setState(() {
                  message = student.study();
                });
              },
              child: const Text("Student Study"),
            ),

            const SizedBox(height: 20),

            // Button cho Teacher
            ElevatedButton(
              onPressed: () {

                // Cập nhật UI
                setState(() {
                  message = teacher.teach();
                });
              },
              child: const Text("Teacher Teach"),
            ),
          ],
        ),
      ),
    );
  }
}