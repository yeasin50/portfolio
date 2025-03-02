import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

enum BulletType {
  //circle to x
  cross(Colors.redAccent),
  //  circle to check
  ok(Colors.greenAccent),
  ;

  const BulletType(this.color);

  final Color color;
}

/// simple bullet point on hover,
/// dot to circle with radial gradient
///
///```dart
///eff.BulletItemView(
///  child: Text(
///    d,
///    style: textTheme.bodyLarge?.copyWith(color: textColor),
///  ),
///)
///```
///
class BulletItemView extends StatefulWidget {
  const BulletItemView({
    super.key,
    this.type = BulletType.ok,
    this.bulletColor,
    this.initialExpand = true,
    required this.child,
  });

  final Widget child;

  ///  the null, it will use default color from [BulletType]
  final Color? bulletColor;

  final BulletType type;

  ///  whether animation should be forward;
  /// default is true
  final bool initialExpand;

  @override
  State<BulletItemView> createState() => _BulletItemViewState();
}

class _BulletItemViewState extends State<BulletItemView>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.short2,
  );
  @override
  void initState() {
    super.initState();
    if (widget.initialExpand) forward(1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void forward(_) {
    controller.forward();
  }

  void reverse(_) {
    controller.reverse();
  }

  late final bulletColor = widget.bulletColor ?? widget.type.color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: Colors.greenAccent)),
      child: Material(
        shape: _CheckShapeBorder(),
        color: Colors.red,
        child: SizedBox(
          width: 200,
          height: 200,
        ),
      ),
    );
    return MouseRegion(
      onEnter: forward,
      onExit: reverse,
      child: GestureDetector(
        onTapDown: forward,
        onTapUp: reverse,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      shape: ShapeBorder.lerp(
                        const CircleBorder(),
                        //FIXME: rotation
                        switch (widget.type) {
                          BulletType.cross =>
                            const StarBorder(points: 4, rotation: math.pi * 10),
                          BulletType.ok => _CheckShapeBorder(),
                        },
                        controller.value,
                      ),
                      color: Colors.transparent,
                      child: SizedBox.square(
                        dimension: lerpDouble(12, 24, controller.value)!,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(colors: [
                              bulletColor,
                              bulletColor.withAlpha(100)
                            ], stops: [
                              0,
                              lerpDouble(.4, 1, controller.value)!
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(child: child!),
              ],
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

class _CheckShapeBorder extends OutlinedBorder {
  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    final width = rect.width / 8;

    final startPoint = rect.centerLeft;

    final points = [
      startPoint,
      startPoint + Offset(width, 0),
      startPoint + Offset(width, width * 2),
      startPoint + Offset(width * 6, width * 2),
      startPoint + Offset(width * 6, width * 3),
      startPoint + Offset(0, width * 3),
    ];
    path
      ..moveTo(rect.center.dx, rect.center.dy)
      ..addPolygon(points, true);
    final tr = Matrix4.identity()
      ..translate(-width * 2, width)
      ..rotateZ(-math.pi / 4);
    return path.transform(tr.storage);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
