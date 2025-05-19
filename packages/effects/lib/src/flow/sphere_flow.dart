import 'dart:math';

import 'package:flutter/material.dart';
import 'sphere_delegate.dart';

/// create   circular [children] animation.
///
class SphereFlow extends StatefulWidget {
  const SphereFlow({
    super.key,
    required this.children,
    required this.callback,
  });
  final List<Widget> children;
  final SphereCircularFlowCallback callback;

  @override
  State<SphereFlow> createState() => _SphereFlowState();
}

class _SphereFlowState extends State<SphereFlow>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController = PrimaryScrollController.maybeOf(context);
      scrollController?.addListener(listener);

      controller.forward();
    });
  }

  void listener() async {
    if (!controller.isCompleted &&
        scrollController!.offset >
            scrollController!.position.maxScrollExtent -
                scrollController!.position.viewportDimension * .25) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      clipBehavior: Clip.none,
      delegate: SphereCircularFlowDelegate(
        animation: controller,
        callback: widget.callback,
      ),
      children: widget.children,
    );
  }
}

class CirclePainter extends CustomPainter {
  const CirclePainter(this.numberOfItems);

  final int numberOfItems;
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2 - (size.width * .02);

    final linePaint = Paint()
      ..color = Colors.white.withAlpha(100)
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < numberOfItems; i++) {
      double angle = (2 * pi / numberOfItems) * i;
      angle = angle + pi / 2;
      final endPoint = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(center, endPoint, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
