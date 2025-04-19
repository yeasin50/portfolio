import 'dart:ui';

import 'package:flutter/material.dart';

/// a cool ball animate inside a [outerColor] ring and
/// inner have [plasmaColor] ball white inside, animate like life.
/// ! Alpha channel will be ignored
///
/// ```dart
/// eff.PlasmaBallSphere(
/// plasmaColor: Colors.cyanAccent,
/// outerColor: const Color.fromARGB(90, 0, 0, 0),
/// child: Center(
///   child: Text(
///     "1231 asd",
///     style: TextStyle(
///       fontSize: 33,
///       color: Colors.white,
///     ),
///   ),
/// ),
///),
/// ```
///
class PlasmaBallSphere extends StatefulWidget {
  const PlasmaBallSphere({
    super.key,
    required this.plasmaColor,
    required this.outerColor,
    this.child,
  });

  final Widget? child;
  final Color plasmaColor;
  final Color outerColor;

  @override
  State<PlasmaBallSphere> createState() => _PlasmaBallSphereState();
}

class _PlasmaBallSphereState extends State<PlasmaBallSphere>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset(
          "packages/effects/assets/plasma_ball.frag");

  late final Future<FragmentProgram> _program = loadMyShader();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    animation = Tween(begin: 0.0, end: 100)
        // .chain(CurveTween(curve: Curves.ease))
        .animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FragmentProgram>(
      future: _program,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
        }

        return snapshot.hasData
            ? CustomPaint(
                painter: _PlasmaBallPainter(
                  plasmaColor: widget.plasmaColor,
                  outerRingColor: widget.outerColor,
                  program: snapshot.data!,
                  animation: animation,
                ),
                child: widget.child ?? SizedBox.square(dimension: 300),
              )
            : widget.child ?? SizedBox.square(dimension: 300);
      },
    );
  }
}

class _PlasmaBallPainter extends CustomPainter {
  const _PlasmaBallPainter({
    required this.program,
    required this.animation,
    required this.outerRingColor,
    required this.plasmaColor,
  }) : super(repaint: animation);

  final FragmentProgram program;
  final Animation animation;
  final Color plasmaColor;
  final Color outerRingColor;

  FragmentShader setValues(FragmentShader s, List<double> data) {
    for (int i = 0; i < data.length; i++) {
      s.setFloat(i, data[i]);
    }
    return s;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<double> rgb(Color color) => [
          color.r,
          color.g,
          color.b,
        ];
    final shader = setValues(program.fragmentShader(), [
      size.width,
      size.height,
      animation.value,

      ///plasma
      ...rgb(plasmaColor),
      ...rgb(outerRingColor)
    ]);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
