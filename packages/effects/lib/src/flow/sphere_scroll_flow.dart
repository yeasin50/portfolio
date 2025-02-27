import 'package:flutter/material.dart';

import 'dart:math' as math;

///  when we are not going to have much  spaces
///``` idea
/// ....*
///...*..
///..*...// scale up
///.*....
///*.....
///````
///TODO: still thining if I want this
class SphereScrollFlowDelegate extends FlowDelegate {
  const SphereScrollFlowDelegate({
    required this.animation,
  }) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = Offset(context.size.width / 2, context.size.height / 2);

    final focalPoint = Offset(
      context.size.width,
      context.size.height,
    );

    double dy = 0;
    double dx = 0;

    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.identity()..translate(center.dx, dy),
      );
      dy += context.getChildSize(i)!.height + 54;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
