import 'package:flutter/material.dart';

class ExperienceListPainter extends CustomPainter {
  const ExperienceListPainter({
    required this.points,
  });

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    ///
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
