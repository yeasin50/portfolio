import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedExpansionTile extends StatefulWidget {
  const AnimatedExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.duration = Durations.extralong4,
    this.initialExpanded = false,
  });

  final Widget title;
  final List<Widget> children;

  final Duration duration;

  final bool initialExpanded;

  @override
  State<AnimatedExpansionTile> createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  late bool isExpanded = widget.initialExpanded;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTap(bool _) {
    isExpanded ? controller.reverse() : controller.forward();
    isExpanded = !isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget.title,
      onExpansionChanged: onTap,
      initiallyExpanded: widget.initialExpanded,
      expandedAlignment: Alignment.centerLeft,
      children: widget.children,
    );
  }
}

///!  damn this doesnt work, someHow need to expose the Size
@Deprecated(" moved to the [ExpansionTile] or use RenderWidget")
class AnimatedExpansionFlowDelegate extends FlowDelegate {
  AnimatedExpansionFlowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;

  Size canvasSize = Size.zero;
  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    double dx = 0.0;

    for (int i = 0; i < context.childCount; i++) {
      final cs = context.getChildSize(i)!;
      context.paintChild(
        i,
        transform: Matrix4.identity()..translate(.0, dy),
      );
      dy += cs.height;
      dx = math.max(cs.width, dx);
    }
    canvasSize = Size(dx, dy);
  }

  // @override
  // Size getSize(BoxConstraints constraints) {
  //   return canvasSize;
  // }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
