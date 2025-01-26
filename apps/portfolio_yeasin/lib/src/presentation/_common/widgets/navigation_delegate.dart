import 'package:flutter/material.dart';

class NavigationDelegate extends FlowDelegate {
  final double t;

  const NavigationDelegate(this.t);

  @override
  void paintChildren(FlowPaintingContext context) {
    final Offset center = Offset(
      context.size.width / 2,
      context.size.height / 2,
    );

    final itemSizes = List.generate(
      context.childCount,
      (index) => context.getChildSize(index),
    );

    double totalWidth =
        itemSizes.fold(0.0, (sum, size) => sum + (size?.width ?? 0.0));
    double totalHeight =
        itemSizes.fold(0.0, (sum, size) => sum + (size?.height ?? 0));

    double x = center.dx - totalWidth / 2;
    double y = 120;

    for (int i = 0; i < itemSizes.length; i++) {
      final size = itemSizes[i]!;

      final offsetX = x * (1.0 - t);
      final offsetY = y * t;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(offsetX, offsetY, 0),
      );

      x += size.width + 3;
      y += size.height + 16;
    }
  }

  @override
  bool shouldRepaint(covariant NavigationDelegate oldDelegate) {
    return oldDelegate.t != t;
  }
}
