import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///  create simple text animation,
/// - scroll up, little fade around it
///
/// if [children] is not null, it will replace the default itemBuilder
/// along with [value], [startValue]
///
class CounterNumberEffect extends StatefulWidget {
  const CounterNumberEffect({
    super.key,
    required this.value,
    this.startValue,
    this.duration = const Duration(milliseconds: 800),
    this.textStyle = const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.children,
  });

  final int value;
  final int? startValue;
  final Duration duration;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;

  final List<Widget>? children;

  @override
  State<CounterNumberEffect> createState() => _CounterNumberEffectState();
}

class _CounterNumberEffectState extends State<CounterNumberEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int startValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      debugLabel: kDebugMode ? "counter number" : null,
      duration: widget.duration,
    );

    startValue = widget.startValue ?? widget.value - 4;
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final t = controller.value;
          double heightFactorModifier = t < .8 ? 1.5 : lerpDouble(1.5, 1, t)!;

          double heightFactor =
              1 / (widget.value - startValue).abs() * heightFactorModifier;

          return ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
              ).createShader(bounds);
            },
            child: Align(
              heightFactor: heightFactor,
              alignment: FractionalOffset(
                0,
                lerpDouble(-1, 1, t)!,
              ),
              child: child!,
            ),
          );
        },
        child: RepaintBoundary(
          child: Padding(
            padding: widget.padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                for (int i = startValue; i <= widget.value; i++)
                  Text(
                    "$i",
                    style: widget.textStyle,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
