import 'package:flutter/material.dart';
import 'dart:math' as math;

@Deprecated(
  "Yo LAzy bro;;; recursive makes like easier ; "
  " use [GoldenSpiralRecursive] instead",
)
class GoldenSpiral extends StatefulWidget {
  const GoldenSpiral({super.key, required this.children})
      : assert(children.length == 4, "children must be less than 5");

  final List<Widget> children;

  @override
  State<GoldenSpiral> createState() => _GoldenSpiralState();
}

class _GoldenSpiralState extends State<GoldenSpiral>
    with SingleTickerProviderStateMixin {
  ///
  late final controller = AnimationController(
    vsync: this,
    duration: Durations.medium1,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boxWidth = MediaQuery.sizeOf(context).width / 1.618;

    return Flow(
      delegate: GoldenSpiralFlowDelegate(controller),
      children: widget.children,
    );
  }
}

/// i can just use row/column
@Deprecated("NO USE bruuuuuuuuuuuuuuuuuuuuu")
class GoldenSpiralFlowDelegate extends FlowDelegate {
  const GoldenSpiralFlowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;
  @override
  void paintChildren(FlowPaintingContext context) {
    if (context.childCount == 0) return;
    final goldenRatio = 1.618;

    context.paintChild(0);

    Size prevItemSize = context.getChildSize(0)!;

    double dx = 0;
    double dy = 0;
    for (int i = 1; i < context.childCount; i++) {
      final offset = switch (i % 4) {
        0 => Offset(prevItemSize.width, 0),
        1 => Offset(prevItemSize.width, 0),
        2 => Offset(prevItemSize.width, prevItemSize.height),
        3 => Offset(prevItemSize.width, 0),
        _ => Offset.zero,
      };

      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..scale(1 / math.pow(goldenRatio, i))
          ..translate(dx, dy),
      );
      prevItemSize = context.getChildSize(i)!;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
