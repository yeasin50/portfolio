import 'package:flutter/material.dart';

///  simple way of handling golder ratio
///
/// ```dart
///
///
/// ```
///
class GoldenSpiralRecursive extends StatelessWidget {
  const GoldenSpiralRecursive({
    super.key,
    this.index = 0,
    this.size = const Size(200, 200),
    required this.children,
  });

  final int index;
  final Size size;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox();

    final mainItem = SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(child: children.first),
    );

    final newItem = GoldenSpiralRecursive(
      size: size * .618,
      index: index + 1,
      children: children.sublist(1),
    );
    return switch (index % 4) {
      0 => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [mainItem, newItem],
        ),
      1 => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [mainItem, newItem],
        ),
      2 => Row(
          children: [newItem, mainItem],
        ),
      3 => Column(
          children: [newItem, mainItem],
        ),
      _ => const Text("Hold ON;"),
    };
  }
}
