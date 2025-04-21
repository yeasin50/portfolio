import 'dart:ui';

import 'package:flutter/material.dart';

/// {@tool snippet}
///
/// a cool ball animate inside a [outerColor] ring and
/// inner have [plasmaColor] ball [coreColor] inside,
/// - Always animate like fish-life animated orb.
/// -  onHover spreed the core
///
/// ! Alpha channel will be ignored
/// ```dart
/// eff.PlasmaBallSphere(
///   coreColor: coreColor: Color(0xFF8E24AA),
///   plasmaColor: Color(0xFF311B92),
///   outerColor: Color(0xFF1E2036),
///   child: Center(
///     child: Text(
///       "1231 asd",
///       style: TextStyle(
///         fontSize: 33,
///         color: Colors.white,
///       ),
///     ),
/// ),
///),
/// ```
/// {@end-tool}
///
class PlasmaBallSphere extends StatefulWidget {
  const PlasmaBallSphere({
    super.key,
    required this.coreColor,
    required this.plasmaColor,
    required this.outerColor,
    this.child,
  });

  /// inner plasma core color
  /// !Alpha channel will be ignored
  final Color coreColor;

  /// around the the core color,
  /// !Alpha channel will be ignored
  final Color plasmaColor;

  /// ring color,
  /// !Alpha channel will be ignored
  final Color outerColor;

  ///  default child is 200x200 box
  final Widget? child;

  @override
  State<PlasmaBallSphere> createState() => _PlasmaBallSphereState();
}

class _PlasmaBallSphereState extends State<PlasmaBallSphere>
    with TickerProviderStateMixin {
  ///
  late AnimationController controller;
  late Animation animation;

  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset(
        "packages/effects/assets/plasma_ball.frag",
      );

  late final Future<FragmentProgram> _program = loadMyShader();

  late final AnimationController coreController;
  late final Animation coreDenseAnimation;
  late final Animation coreSpreedAnimation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 200),
    );
    animation = Tween(begin: 0.0, end: 100) //
        .animate(controller);
    controller.repeat(reverse: true);

    coreController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    coreSpreedAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: .10, end: .02), weight: .4),
      TweenSequenceItem(tween: Tween(begin: .02, end: .25), weight: .6),
    ]).animate(CurvedAnimation(
      parent: coreController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
    ));

    coreDenseAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: .0, end: .1), weight: .3),
    ]).animate(CurvedAnimation(
      parent: coreController,
      curve: const Interval(.7, 1.0, curve: Curves.easeInOut),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    coreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        coreController.forward();
      },
      onExit: (_) {
        coreController.reverse();
      },
      child: AnimatedBuilder(
        animation: coreController,
        builder: (context, child) {
          return FutureBuilder<FragmentProgram>(
            future: _program,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
              }

              return snapshot.hasData
                  ? CustomPaint(
                      painter: _PlasmaBallPainter(
                        coreColor: widget.coreColor,
                        plasmaColor: widget.plasmaColor,
                        outerRingColor: widget.outerColor,
                        program: snapshot.data!,
                        animation: animation,
                        coreSpreed: coreSpreedAnimation.value,
                        coreDense: coreDenseAnimation.value,
                      ),
                      child: child,
                    )
                  : child!;
            },
          );
        },
        child: widget.child ?? SizedBox.square(dimension: 300),
      ),
    );
  }
}

class _PlasmaBallPainter extends CustomPainter {
  const _PlasmaBallPainter({
    required this.program,
    required this.animation,
    required this.outerRingColor,
    required this.plasmaColor,
    required this.coreColor,
    this.coreDense = 0.0,
    this.coreSpreed = 0.15,
  }) : super(repaint: animation);

  final FragmentProgram program;
  final Animation animation;

  final Color coreColor;
  final Color plasmaColor;
  final Color outerRingColor;

  /// from  0 -  1
  final double coreDense;

  /// better looks from  .15, max 1
  final double coreSpreed;

  FragmentShader setValues(FragmentShader s, List<double> data) {
    for (int i = 0; i < data.length; i++) {
      s.setFloat(i, data[i]);
    }
    return s;
  }

  @override
  void paint(Canvas canvas, Size size) {
    assert(coreDense >= 0 && coreDense <= 1, "coreDense should be within 0-1");
    assert(
        coreSpreed >= 0 && coreSpreed <= 1, "coreSpreed should be within 0-1");

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
      ...rgb(outerRingColor),
      ...rgb(coreColor),
      coreDense,
      coreSpreed,
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
