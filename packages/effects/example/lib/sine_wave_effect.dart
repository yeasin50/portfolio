import 'dart:ui';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SineWaveEffect(
          child: SizedBox.square(
            dimension: 300,
          ),
        ),
      ),
    ),
  );
}

class SineWaveEffect extends StatefulWidget {
  const SineWaveEffect({
    super.key,
    required this.child,
  });
  final Widget? child;

  @override
  State<SineWaveEffect> createState() => _SineWaveEffectState();
}

class _SineWaveEffectState extends State<SineWaveEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset("shaders/plasma_ball.frag");

  late final Future<FragmentProgram> _program = loadMyShader();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 100),
    );
    animation = Tween(begin: 0.0, end: 100.0).animate(controller);
    controller.repeat();
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
        return Center(
          child: Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              if (snapshot.hasData)
                Positioned.fill(
                  child: CustomPaint(
                    painter: PlasmaBallPainter(
                      program: snapshot.data!,
                      animation: animation,
                    ),
                  ),
                ),
              widget.child ??
                  SizedBox.square(
                    dimension: 300,
                  )
            ],
          ),
        );
      },
    );
  }
}

class PlasmaBallPainter extends CustomPainter {
  const PlasmaBallPainter({
    required this.program,
    required this.animation,
  }) : super(repaint: animation);

  final FragmentProgram program;

  final Animation animation;

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
      ...rgb(Colors.cyanAccent),
      //outter right
      ...rgb(Colors.amberAccent)
    ]);

    canvas.drawPaint(Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
