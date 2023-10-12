import 'package:about/about.dart';
import 'package:flutter/material.dart';

class AboutDataProvider extends InheritedWidget {
  const AboutDataProvider({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  final AboutPageData data;

  @override
  bool updateShouldNotify(covariant AboutDataProvider oldWidget) =>
      data != oldWidget.data;

  static AboutDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AboutDataProvider>();
  }
}
