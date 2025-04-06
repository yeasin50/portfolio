import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef SphereCircularFlowCallback = Function(List<Offset> childPosition);

/// circular flow from bottom-center to circle
/// little opacity on animation
///
class SphereCircularFlowDelegate extends FlowDelegate {
  const SphereCircularFlowDelegate({
    required this.animation,
    required this.callback,
  }) : super(repaint: animation);

  final Animation animation;

  final SphereCircularFlowCallback callback;

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = Offset(context.size.width / 2, context.size.height / 2);

    List<Size> childSizes = [];
    for (int i = 0; i < context.childCount; i++) {
      final cs = context.getChildSize(i)!;
      childSizes.add(cs);
    }

    double maxDimension = childSizes
        .map((s) => math.max(s.width, s.height)) //
        .reduce(math.max);

    final radius =
        (math.min(context.size.width, context.size.height) - maxDimension) / 2;

    double scale = 1.0;

    scale = (radius / maxDimension).clamp(0.25, 1.0);

    final totalChildren = context.childCount;

    List<Offset> positions = [];
    for (int i = 0; i < totalChildren; i++) {
      double angle = math.pi;
      angle += (i * (2 * math.pi) / totalChildren) * animation.value;

      double dx = center.dx + radius * math.cos(angle);
      double dy = center.dy + radius * math.sin(angle);

      final childSize = childSizes[i];

      final adjustedWidth = childSize.width * scale;
      final adjustedHeight = childSize.height * scale;

      final opacity = lerpDouble(
          1 - ((context.childCount - i) * .2), 1.0, animation.value)!;

      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(dx - adjustedWidth / 2, dy - adjustedHeight / 2)
          ..scale(scale),
        opacity: opacity,
      );
      positions.add(Offset(dx, dy));
    }
    callback.call(positions);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
