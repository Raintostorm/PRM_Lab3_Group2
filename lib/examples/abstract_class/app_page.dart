import 'package:flutter/material.dart';

// Ví dụ 3 — AppPage giống StatelessWidget. Doc: md/abstract-class.md mục 6.3

abstract class AppPage {
  String get title;

  /// Giống `StatelessWidget.build` — phần bắt buộc subclass implement.
  Widget build(BuildContext context);
}

class HomePage extends AppPage {
  @override
  String get title => 'Trang chủ';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('HomePage — extends AppPage (abstract)'),
    );
  }
}

class AboutPage extends AppPage {
  @override
  String get title => 'Giới thiệu';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('AboutPage — override build()'),
    );
  }
}

/// Host hiển thị bất kỳ [AppPage] nào — không cần biết lớp con cụ thể.
class AppPageHost extends StatelessWidget {
  const AppPageHost({super.key, required this.page});

  final AppPage page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(page.title)),
      body: page.build(context),
    );
  }
}
