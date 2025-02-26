import 'package:flutter/material.dart';

class SpherePainter extends CustomPainter {
  final Alignment lightAlignment;
  final List<Color> shades;

  const SpherePainter({
    required this.lightAlignment,
    required this.shades,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final sphereGradient = RadialGradient(
      center: lightAlignment,
      radius: 1.0,
      colors: shades,
    );

    final spherePaint = Paint()
      ..shader = sphereGradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, spherePaint);

    final shadowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.3)
      ..color = Colors.black.withAlpha(75);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.6),
        width: radius * 1.6,
        height: radius * 0.4,
      ),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
