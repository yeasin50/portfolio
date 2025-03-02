import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    required this.child,
    this.bulletColor = Colors.redAccent,
    this.initialExpand = true,
  });

  final Widget child;
  final Color bulletColor;

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

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: ShapeBorder.lerp(
                      const CircleBorder(),
                      //FIXME: rotation
                      const StarBorder(points: 4, rotation: math.pi * 10),
                      controller.value,
                    ),
                    color: Colors.transparent,
                    child: SizedBox.square(
                      dimension: lerpDouble(12, 24, controller.value)!,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [
                            widget.bulletColor,
                            widget.bulletColor.withAlpha(100)
                          ], stops: [
                            0,
                            lerpDouble(.4, 1, controller.value)!
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                child!,
              ],
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
