import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

///  main background of Portfolio
class BackgroundView extends StatefulWidget {
  const BackgroundView({
    super.key,
    required this.child,
    required this.colors,
    this.shaderPath,
  });

  final Widget child;
  final List<Color> colors;

  ///  if [shaderPath] is null it will use [CustomPainter]
  final String? shaderPath;

  @override
  State<BackgroundView> createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Offset _focalPoint = const Offset(.5, .5);
  Offset _smoothFocalPoint = const Offset(.5, .5);

  @override
  void initState() {
    super.initState();

    _ticker = Ticker(_tick)..start();
  }

  // it is not that bad;  fps is good
  void _tick(Duration elapsed) {
    _smoothFocalPoint = Offset(
      lerpDouble(_smoothFocalPoint.dx, _focalPoint.dx, 0.1)!,
      lerpDouble(_smoothFocalPoint.dy, _focalPoint.dy, 0.1)!,
    );
  }

  void onHover(PointerHoverEvent event) {
    setState(() {
      _focalPoint = event.localPosition;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  late final List<Color> bgColors = widget.colors;

  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset(widget.shaderPath ?? "");

  late final Future<FragmentProgram> _program = loadMyShader();

  Widget painterChild() {
    return CustomPaint(
      painter: _BGPainter(
        focalPoint: _smoothFocalPoint,
        colors: bgColors,
      ),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shaderPath == null) {
      return painterChild();
    }
    return MouseRegion(
      onHover: onHover,
      child: FutureBuilder(
        future: _program,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          print("err ${snapshot.error.toString()}");
          if (!snapshot.hasData) {
            return painterChild();
          }
          return CustomPaint(
            painter: _BGShaderPainter(
              program: snapshot.data!,
              colors: widget.colors,
              focalPoint: _smoothFocalPoint,
            ),
            child: widget.child,
          ); 
        },
      ),
    );
  }
}

///! still Dither
/// const Color(0xFF343C59),
// const Color(0xFF1E2036),
class _BGShaderPainter extends CustomPainter {
  const _BGShaderPainter({
    required this.program,
    required this.colors,
    required this.focalPoint,
  });

  final FragmentProgram program;
  final List<Color> colors;

  final Offset focalPoint;

  @override
  void paint(Canvas canvas, Size size) {
    var shader = program.fragmentShader();

    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    shader.setFloat(2, .5);
    shader.setFloat(3, .5);

    shader.setFloat(4, .50);

    final focalColor = colors.first;
    shader.setFloat(5, focalColor.r);
    shader.setFloat(6, focalColor.g);
    shader.setFloat(7, focalColor.b);
    shader.setFloat(8, focalColor.a);

    final edgeColor = colors.last;
    shader.setFloat(9, edgeColor.r);
    shader.setFloat(10, edgeColor.g);
    shader.setFloat(11, edgeColor.b);
    shader.setFloat(12, edgeColor.a);

    canvas.drawPaint(Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///  simple radial gradient with [colors]
/// which  center is [focalPoint]
///
class _BGPainter extends CustomPainter {
  const _BGPainter({
    required this.focalPoint,
    required this.colors,
  });

  final Offset focalPoint;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = RadialGradient(
      focal: Alignment(
        (focalPoint.dx / size.width) * 2 - 1,
        (focalPoint.dy / size.height) * 2 - 1,
      ),
      colors: colors.reversed.toList(),
      radius: 1.4,
      tileMode: TileMode.clamp,
    );

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
