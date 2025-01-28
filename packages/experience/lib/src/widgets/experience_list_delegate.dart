import 'package:flutter/material.dart';

class ExperienceListDelegate extends FlowDelegate {
  const ExperienceListDelegate({
    this.padding = const EdgeInsets.all(12),
  });

  final EdgeInsetsGeometry padding;

  @override
  void paintChildren(FlowPaintingContext context) {
    double yOffset = 0.0;

    for (int i = 0; i < context.childCount; i++) {
      final childSize = context.getChildSize(i)!;

      context.paintChild(
        i,
        transform: Matrix4.identity()..translate(padding.horizontal, yOffset),
      );

      yOffset += childSize.height + padding.vertical;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
