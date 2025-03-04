import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:math' as math;

///  simple expansion animated icon to indicate expanded or not
/// todo: ADD full tile effect

class AnimatedExpansionIcon extends StatefulWidget {
  const AnimatedExpansionIcon({
    super.key,
    required this.isExpanded,
  });

  final bool isExpanded;

  @override
  State<AnimatedExpansionIcon> createState() => _AnimatedExpansionIconState();
}

class _AnimatedExpansionIconState extends State<AnimatedExpansionIcon>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _expansionController;

  ///
  void toggleAnimation({bool? value}) {
    isExpanded = value ?? !isExpanded;
    isExpanded ? _expansionController.forward() : _expansionController.reverse();
  }

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;

    _expansionController = AnimationController(vsync: this, duration: Durations.medium1);

    if (isExpanded) {
      _expansionController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedExpansionIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      toggleAnimation(value: widget.isExpanded);
    }
  }

  @override
  void dispose() {
    _expansionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _expansionController,
      builder: (context, child) {
        final tr = Matrix4.identity()
          ..rotateZ(math.pi * _expansionController.value)
          ..scale(lerpDouble(1.5, 1, _expansionController.value));
        return Transform(
          transform: tr,
          alignment: FractionalOffset.center,
          child: child!,
        );
      },
      child: Icon(Icons.expand_more, size: 24),
    );
  }
}
