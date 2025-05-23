import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

import '../utils/mouse_tracker_mixin.dart';

///  simple [SphereView] with mouse hover effect
///  with  radial gradient from [colors]
///
///```dart
/// Padding(
///   padding: const EdgeInsets.all(56.0),
///   child: Stack(
///     clipBehavior: Clip.none,
///     children: [
///       for (double x = -1; x <= 1; x += .5)
///         for (double y = -1; y <= 1; y += 1)
///           Align(
///             alignment: Alignment(x, y),
///             child: eff.SphereView(
///               key: ValueKey("sphere $x $y"),
///               child: Padding(
///                 padding: const EdgeInsets.all(38.0),
///                 child: Text(
///                   "Hey",
///                   style: TextStyle(
///                     fontSize: 55,
///                   ),
///                 ),
///               ),
///             ),
///           ),
///     ],
///   ),
/// ),
/// ```
///
class SphereView extends StatefulWidget {
  const SphereView({
    super.key,
    this.child,
    this.colors = const [
      Colors.blue,
      Colors.indigo,
      Colors.black,
    ],
    this.hoverColor,
    this.disableHover = false,
  });

  final Widget? child;
  final List<Color> colors;

  /// if null  it gonna use [colors].first
  final Color? hoverColor;

  /// default is false
  final bool disableHover;

  @override
  State<SphereView> createState() => _SphereViewState();
}

class _SphereViewState extends State<SphereView>
    with MouseTrackerMixin, SingleTickerProviderStateMixin {
  ///

  Alignment lightAlignment = Alignment.center;
  final GlobalKey _key = GlobalKey();

  Offset? _widgetPosition;
  late Size _boxSize;

  void getSphereProperties(_) {
    final RenderBox? box =
        _key.currentContext?.findRenderObject() as RenderBox?;

    _widgetPosition = box?.localToGlobal(Offset.zero);
    if (_widgetPosition == null) return;

    _boxSize = box!.size;
  }

  //FIXME: little offset issue but i kinda like it
  void onMouseUpdate(Offset offset) {
    if (_widgetPosition == null) return;
    getSphereProperties(0);

    // diff from center
    double dx = offset.dx - _widgetPosition!.dx;
    double dy = offset.dy - _widgetPosition!.dy;

    double radiusX = _boxSize.width * 2.5;
    double radiusY = _boxSize.height * 2.5;

    double normalizedX = (dx / radiusX).clamp(-1, 1);
    double normalizedY = (dy / radiusY).clamp(-1, 1);

    lightAlignment = Alignment(normalizedX, normalizedY);

    setState(() {});
  }

  late Animation<double> scaleAnimation;
  late AnimationController hoverController;

  @override
  void initState() {
    super.initState();
    onMouseMove = onMouseUpdate;
    WidgetsBinding.instance.addPostFrameCallback(getSphereProperties);

    assert(widget.colors.isNotEmpty, "colors can't be empty");

    hoverController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
      lowerBound: 0,
      upperBound: 1,
    );

    scaleAnimation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: hoverController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    hoverController.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DoubleProperty('hoverScale', scaleAnimation.value));
    properties.add(FlagProperty(
      'isHovering',
      value: hoverController.isAnimating,
    ));
    properties.add(DoubleProperty('hoverProgress', hoverController.value));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.disableHover ? null : hoverController.forward(),
      onExit: (event) => hoverController.reverse(),
      child: AnimatedBuilder(
        animation: hoverController,
        builder: (context, child) {
          return ScaleTransition(
            scale: scaleAnimation,
            child: child!,
          );
        },
        child: CustomPaint(
          key: _key,
          painter: _SpherePainter(
            lightAlignment: lightAlignment,
            shades: widget.colors,
            hoverAnimation: hoverController,
            hoverColor: widget.hoverColor,
          ),
          child: widget.child ??
              SizedBox.square(
                dimension: 100,
              ),
        ),
      ),
    );
  }
}

class _SpherePainter extends CustomPainter {
  _SpherePainter({
    required this.lightAlignment,
    required this.shades,
    this.hoverAnimation,
    this.hoverColor,
  }) : super(repaint: hoverAnimation);

  final Alignment lightAlignment;
  final List<Color> shades;

  /// if null,  then it uses from [shades].first
  final Color? hoverColor;
  final Animation<double>? hoverAnimation;

  void buildHoverEffect(Canvas canvas, Size size) {
    if (hoverAnimation == null) return;
    final center = Offset(size.width / 2, size.height / 2);

    ///hover glow
    double hoverRadius = lerpDouble(
      size.width * 0.5,
      size.width * .75,
      hoverAnimation!.value,
    )!;

    final glowColor = hoverColor ?? shades.first;
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          glowColor.withAlpha(0),
          glowColor,
          glowColor.withValues(alpha: 0, green: 0, red: 0),
        ],
        radius: .5,
        stops: [0.45, .5, 1],
        center: Alignment.center,
      ).createShader(
        Rect.fromCircle(center: center, radius: hoverRadius),
      );

    canvas.drawCircle(center, hoverRadius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    buildHoverEffect(canvas, size);
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

///  radial gradient with [color] on [animation]
@Deprecated("Not needed anymore, directly implemented inside [_SpherePainter]")
class _HoverPainter extends CustomPainter {
  const _HoverPainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  final Color color;
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    double radius = lerpDouble(
      size.width * 0.5,
      size.width * .75,
      animation.value,
    )!;

    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withAlpha(0),
          color,
          color.withValues(alpha: 0, green: 0, red: 0),
        ],
        radius: .5,
        stops: [0.45, .5, 1],
        center: Alignment.center,
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
