import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

part 'bullet_view.dart';

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
    this.type = BulletType.concern,
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
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                BulletView(
                  type: widget.type,
                  t: controller.value,
                  bulletColor: widget.bulletColor,
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
