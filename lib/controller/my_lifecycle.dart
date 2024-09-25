part of '../mymo.dart';

abstract class MyLifecycle {
  /// Dipanggil ketika controller diinisialisasi
  void onInit() {}

  /// Dipanggil ketika controller siap digunakan setelah `initState`
  void onReady() {}

  /// Dipanggil ketika controller dihapus (dispose)
  void onClose() {}
}

class MyLifecycleWrapper extends StatefulWidget {
  final Widget child;
  final MyController controller;

  const MyLifecycleWrapper({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  _MyLifecycleWrapperState createState() => _MyLifecycleWrapperState();
}

class _MyLifecycleWrapperState extends State<MyLifecycleWrapper> {
  @override
  void initState() {
    super.initState();
    widget.controller.onInit(); // Panggil onInit pada controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.onReady(); // Panggil onReady setelah frame pertama
    });
  }

  @override
  void dispose() {
    widget.controller.onClose(); // Panggil onClose saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
