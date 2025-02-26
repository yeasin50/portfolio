import 'package:flutter/material.dart';

import '../utils/mouse_tracker_mixin.dart';

///  simple [SphereView] with mouse hover effect
///  with  radial gradient from [colors]
///
///```dart
/// body: Center(
///   child: Stack(
///     children: [
///       for (double x = -1; x < 1; x += .4)
///         for (double y = -1; y < 1; y += .5)
///           Align(
///             key: ValueKey(" $x $y"), // use keys if you get conflicts
///             alignment: Alignment(x, y),
///             child: eff.SphereView(
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
  });

  final Widget? child;
  final List<Color> colors;

  @override
  State<SphereView> createState() => _SphereViewState();
}

class _SphereViewState extends State<SphereView> with MouseTrackerMixin {
  @override
  void initState() {
    super.initState();
    onMouseMove = onMouseUpdate;
    WidgetsBinding.instance.addPostFrameCallback(findTextWidgetPosition);
  }

  Alignment lightAlignment = Alignment.center;
  final GlobalKey _key = GlobalKey();

  Offset? _widgetPosition;
  late Size _boxSize;
  void findTextWidgetPosition(_) {
    final RenderBox? box =
        _key.currentContext?.findRenderObject() as RenderBox?;

    _widgetPosition = box?.localToGlobal(Offset.zero);
    if (_widgetPosition == null) return;

    _boxSize = box!.size;
  }

  void onMouseUpdate(Offset offset) {
    if (_widgetPosition == null) return;

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

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: _key,
      painter: _SpherePainter(
        lightAlignment: lightAlignment,
        shades: widget.colors,
      ),
      child: widget.child ??
          SizedBox.square(
            dimension: 100,
          ),
    );
  }
}

class _SpherePainter extends CustomPainter {
  final Alignment lightAlignment;
  final List<Color> shades;

  const _SpherePainter({
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
