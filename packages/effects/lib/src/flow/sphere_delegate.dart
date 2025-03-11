import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

typedef SphereCircularFlowCallback = Function(List<Offset> childPosition);

/// circular flow from bottom-center to circle
/// little opacity on animation
///
/// ! but not good for mobile/small screen :)
class SphereCircularFlowDelegate extends FlowDelegate {
  const SphereCircularFlowDelegate({
    required this.animation,
    required this.callback,
  }) : super(repaint: animation);

  final Animation animation;

  //TODO: instead we can pass destination from parent and lerp
  final SphereCircularFlowCallback callback;

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = Offset(
      context.size.width / 2,
      context.size.height / 2,
    );

    List<Size> childSizes = [];
    for (int i = 0; i < context.childCount; i++) {
      final cs = context.getChildSize(i)!;
      childSizes.add(cs);
    }

    double maxDimension = childSizes
        .map((s) => math.max(s.width, s.height)) //
        .reduce(math.max);

    maxDimension *= 1.5;

    final radius = (math.min(context.size.width, context.size.height) / 2) -
        (maxDimension);

    final totalChildren = context.childCount;

    List<Offset> positions = [];
    for (int i = 0; i < totalChildren; i++) {
      double angle = math.pi / 2;
      angle += (i * (2 * math.pi) / totalChildren) * animation.value;

      double dx = center.dx + radius * math.cos(angle);
      double dy = center.dy + radius * math.sin(angle);

      final opacity = lerpDouble(
        1 - ((context.childCount - i) * .2),
        1.0,
        animation.value,
      )!;
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(dx - childSizes[i].width / 2, dy),
        opacity: opacity,
      );
      positions.add(Offset(dx, dy + childSizes[i].height / 2));
    }
    callback.call(positions);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
