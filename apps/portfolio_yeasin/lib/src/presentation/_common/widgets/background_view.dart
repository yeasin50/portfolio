import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../../app/app_theme.dart';

class BackgroundView extends StatefulWidget {
  const BackgroundView({
    super.key,
    required this.child,
    this.isDark = false,
  });

  final Widget child;
  final bool isDark;

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

  late final List<Color> bgColors =
      Theme.of(context).extension<AppTheme>()!.backgroundGradient;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: CustomPaint(
        painter: _BGPainter(
          focalPoint: _smoothFocalPoint,
          colors: bgColors,
        ),
        child: widget.child,
      ),
    );
  }
}

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

extension AlignmentRotation on Alignment {
  Alignment rotate(double angle) {
    final radians = angle; // already in radians
    final x = cos(radians) * this.x - sin(radians) * this.y;
    final y = sin(radians) * this.x + cos(radians) * this.y;
    return Alignment(x, y);
  }
}
