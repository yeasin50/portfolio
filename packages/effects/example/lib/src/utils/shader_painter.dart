import 'dart:ui';

import 'package:flutter/material.dart';
 

class BackgroundPainter extends CustomPainter {
  final FragmentProgram program;
  final Offset focalPoint;

  // final Animation<double> value;
 

  const BackgroundPainter({
    required this.program,
    required this.focalPoint, 
    // required this.value,
  })
  //  : super(repaint: value)
   ;

  @override
  void paint(Canvas canvas, Size size) {
    final shader = program.fragmentShader()
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, focalPoint.dx)
      ..setFloat(3, focalPoint.dy)
      ..setFloat(4, .3)
      ;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) =>
      oldDelegate.focalPoint != focalPoint;
}
