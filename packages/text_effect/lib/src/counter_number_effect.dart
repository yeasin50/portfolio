import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CounterNumberEffect extends StatefulWidget {
  const CounterNumberEffect({
    super.key,
    required this.value,
    this.startValue,
    this.duration = const Duration(milliseconds: 800),
    this.textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  });

  final int value;
  final int? startValue;
  final Duration duration;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;

  @override
  State<CounterNumberEffect> createState() => _CounterNumberEffectState();
}

class _CounterNumberEffectState extends State<CounterNumberEffect>
    with SingleTickerProviderStateMixin {
  int _currentValue = 0;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      debugLabel: kDebugMode ? "counter number" : null,
      duration: widget.duration,
    );

    _currentValue = widget.startValue ?? widget.value - 10;
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.green,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final slideTween = Tween<Offset>(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(controller);
          return SlideTransition(
            position: slideTween,
            child: child!,
          );
        },
        child: Text(
          "10",
          style: widget.textStyle,
        ),
      ),
    );
  }
}
