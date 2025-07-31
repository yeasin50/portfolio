import 'dart:ui';

import 'package:effects/effects.dart';
import 'package:flutter/material.dart';

part 'text_reveal_with_animated_arrow.dart';

///  create simple animated Arrow bullet point and next to the
/// [child] as text
/// ```dart
/// eff.AnimatedArrowView(
///       child: DefaultTextStyle(
///         style: theme.tldr.copyWith(color: Colors.black), //FIXME:
///         child: Text(
///           "Available from $availableDate",
///         ),
///       ),
///     );
/// ```
class AnimatedArrowView extends StatefulWidget {
  const AnimatedArrowView({
    super.key,
    this.duration = Durations.long3,
    required this.child,
    this.backgroundColor,
    this.bulletColor,
    this.initialAnimationValue = 0,
  });

  final Duration duration;

  final double initialAnimationValue;

  /// if null it will use [EffectThemeExt]' s card color
  ///
  final Color? backgroundColor;

  /// if null it will use [EffectThemeExt]' s glow color
  ///
  final Color? bulletColor;

  final Widget child;

  @override
  State<AnimatedArrowView> createState() => _AnimatedArrowViewState();
}

class _AnimatedArrowViewState extends State<AnimatedArrowView>
    with TickerProviderStateMixin {
  //

  late final AnimationController controller;

  late final AnimationController rippleController;

  @override
  void initState() {
    super.initState();
    assert(
        widget.initialAnimationValue >= 0 &&
            widget.initialAnimationValue <= 1.0,
        "initialAnimationValue should be withing 0-1");

    rippleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(
        () {
          if (controller.isCompleted) {
            rippleController.animateBack(1);
          } else {
            rippleController.repeat();
          }
        },
      );
    controller.value = widget.initialAnimationValue;
  }

  void onForward(_) {
    controller.forward();
  }

  void onExit(_) {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<EffectThemeExt>()!;

    return MouseRegion(
      onEnter: onForward,
      onExit: onExit,
      child: AnimatedBuilder(
        animation: Listenable.merge([controller, rippleController]),
        builder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: widget.backgroundColor ?? theme.cardColor.first,
                shape: _ArrowShapeBuilder(
                  animation: controller,
                  rippleAnimation: rippleController,
                  color: widget.bulletColor ?? theme.glowColor,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: lerpDouble(42, 16, controller.value)!,
                  top: 6,
                  bottom: 6,
                  right: 16,
                ),
                child: child!,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _ArrowShapeBuilder extends OutlinedBorder {
  const _ArrowShapeBuilder({
    required this.animation,
    required this.color,
    required this.rippleAnimation,
    this.numberOfRipple = 5,
  });

  final Color color;
  final Animation animation;
  final Animation rippleAnimation;
  final int numberOfRipple;

  @override
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final radius = rect.height;

    for (int i = 1; i <= numberOfRipple; i++) {
      final ripplePaint = Paint()
        ..color =
            color.withAlpha(lerpDouble(255, 50, rippleAnimation.value)!.toInt())
        ..style = PaintingStyle.stroke
        ..strokeWidth = lerpDouble(1, 8, rippleAnimation.value)!;

      ///  expand height
      canvas.drawCircle(
        rect.centerLeft,
        lerpDouble(radius, rect.width, rippleAnimation.value * i)!,
        ripplePaint,
      );
    }

    final Paint paint = Paint()..color = color;

    final height = rect.height;

    final points = [
      rect.topLeft,
      Offset.lerp(
        Offset(rect.left + height / 2, rect.top),
        rect.topRight,
        animation.value,
      )!,
      Offset.lerp(
        Offset(rect.left + (height), rect.centerRight.dy),
        rect.centerRight,
        animation.value,
      )!,
      Offset.lerp(
        Offset(rect.left + height / 2, rect.bottom),
        rect.bottomRight,
        animation.value,
      )!,
      rect.bottomLeft,
    ];

    Path arrow = Path()..addPolygon(points, true);

    canvas.drawPath(arrow, paint);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  ShapeBorder scale(double t) => this;
}
