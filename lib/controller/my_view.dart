part of '../mymo.dart';

/// Base StatelessView mirip seperti GetView di GetX
abstract class MyView<T extends MyController> extends StatelessWidget {
  final T controller;

  const MyView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MyLifecycleWrapper(
      controller: controller,
      child: buildPage(context),
    );
  }

  /// Ini adalah build method yang di-override di masing-masing view.
  Widget buildPage(BuildContext context);
}
