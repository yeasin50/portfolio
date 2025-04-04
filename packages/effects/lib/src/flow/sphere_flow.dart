import 'dart:math';

import 'package:flutter/material.dart';
import 'sphere_delegate.dart';

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
  )..forward();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(widget.children.length),
      child: Flow(
        delegate: SphereCircularFlowDelegate(
          animation: controller,
          callback: widget.callback,
        ),
        children: widget.children,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  const CirclePainter(this.numberOfItems);

  final int numberOfItems;
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width, size.height) / 2,
        height: radius * 2,
        width: radius * 2,
      ),
      Paint()..color = Colors.red.withAlpha(40),
    );

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
