import 'package:flutter/material.dart';

import 'dart:math' as math;

double _degToRad(double deg) => deg * (math.pi / 180);

///Will play later
class ConnectFlowDelegate extends FlowDelegate {
  const ConnectFlowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    final double startAngle = _degToRad(-0.0);
    final double sweepAngle = _degToRad(90.0);
    const padding = 16.0;

    final double angleStep = sweepAngle / (context.childCount - 1);

    List<Size> itemSize = [];

    for (int i = 0; i < context.childCount; i++) {
      itemSize.add(context.getChildSize(i)!);
    }

    for (int i = 0; i < context.childCount; i++) {
      double angle = (startAngle + (angleStep * i)) * (math.pi / 180);
      double radius = itemSize.sublist(0, i).fold(
                0.0,
                (p, e) => p + e.width + padding,
              ) *
          animation.value;

      double x = radius * math.cos(angle);
      double y = radius * math.sin(angle);
      final m = Offset(x, 0) + Offset(0, radius * (1 - animation.value));
      // final m = Offset(x, 0);

      final t = animation.value;
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(m.dx, m.dy)
          ..scale(t),
        opacity: t * 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ConnectFlowDelegate oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

class ConnectMultiChildDelegate extends MultiChildLayoutDelegate {
  ConnectMultiChildDelegate({required this.animation})
      : super(relayout: animation);

  final Animation animation;

  @override
  void performLayout(Size size) {
    const padding = 24.0;
    List<Size> itemSize = [];

    for (int i = 0; i < 4; i++) {
      final item = layoutChild(i, BoxConstraints.loose(size));
      itemSize.add(item);
    }

    final double startAngle = _degToRad(-90.0);
    final double sweepAngle = _degToRad(90.0);

    final double angleStep = sweepAngle / (itemSize.length - 1);

    for (int i = 0; i < itemSize.length; i++) {
      double angle = (startAngle + (angleStep * i)) * (math.pi / 180);
      double radius = itemSize.sublist(0, i).fold(
            0.0,
            (p, e) => p + e.width + padding,
          );

      double x = radius * math.cos(angle);
      double y = radius * math.sin(angle);

      positionChild(
          i, Offset(x, y) + Offset(0, radius * (1 - animation.value)));
    }
  }

  @override
  bool shouldRelayout(covariant ConnectMultiChildDelegate oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
