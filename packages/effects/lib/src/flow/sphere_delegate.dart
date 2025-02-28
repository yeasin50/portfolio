import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// circular flow from bottom-center to circle
/// little opacity on animation
///
/// ! but not good for mobile/small screen :)
class SphereCircularFlowDelegate extends FlowDelegate {
  const SphereCircularFlowDelegate({
    required this.animation,
  }) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = Offset(
      context.size.width / 2,
      context.size.height / 2,
    );

    final childSize = context.getChildSize(0);
    final totalChildren = context.childCount;
    final radius = math.min(
          context.size.width - (childSize!.width * 2),
          context.size.height - (childSize.height * 2),
        ) /
        2;

    for (int i = 0; i < totalChildren; i++) {
      double angle = math.pi / 2;
      angle += (i * (2 * math.pi) / totalChildren) * animation.value;

      double dx = center.dx + radius * math.cos(angle);
      double dy = center.dy + radius * math.sin(angle);

      dx -= childSize.width / 2;
      dy -= childSize.height / 2;

      final opacity = lerpDouble(
        1 - ((context.childCount - i) * .2),
        1.0,
        animation.value,
      )!;
      context.paintChild(
        i,
        transform: Matrix4.identity()..translate(dx, dy),
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
