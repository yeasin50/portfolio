import 'package:flutter/material.dart';
import 'dart:math' as math;

@Deprecated("Use [SphereCircularFlowDelegate] or add more fancy  stuffs ")
class SphereMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  SphereMultiChildLayoutDelegate({
    required this.animation,
    required this.totalChildren,
  }) : super(relayout: animation);

  final Animation animation;
  final int totalChildren;

  @override
  void performLayout(Size size) {
    if (!hasChild(0)) return;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < totalChildren; i++) {
      final radius = math.min(
            size.width,
            size.height,
          ) /
          3;
      double angle = math.pi / 2;
      angle += (i * (2 * math.pi) / totalChildren) * animation.value;

      double dx = center.dx + radius * math.cos(angle);
      double dy = center.dy + radius * math.sin(angle);

      // dx -= childSize.width / 2;
      // dy -= childSize.height / 2;

      layoutChild(i, BoxConstraints.loose(size));
      positionChild(i, Offset(dx, dy));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
