// Ví dụ 4 — Ghi chú framework. Doc: md/abstract-class.md mục 6.4

List<String> frameworkAbstractClassNotes() => const [
      'Widget, StatelessWidget, StatefulWidget, State đều là abstract class.',
      'App extends StatelessWidget → override build(BuildContext).',
      'App extends StatefulWidget → override createState() → State<T>.',
      'Abstract class = contract + hành vi dùng chung (setState, key, lifecycle).',
    ];
