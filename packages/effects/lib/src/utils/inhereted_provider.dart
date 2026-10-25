import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({
    super.key,
    required this.value,
    required super.child,
  });

  final T value;

  static T? of<T>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider?.value;
  }

  @override
  bool updateShouldNotify(covariant InheritedProvider<T> oldWidget) {
    return value != oldWidget.value;
  }
}
