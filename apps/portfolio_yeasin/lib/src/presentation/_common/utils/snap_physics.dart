import 'package:flutter/material.dart';

/// TO snap on dragging ;
/// Used on Intro in HomePage
class IntroSnapScrollPhysics extends ScrollPhysics {
  const IntroSnapScrollPhysics({
    required this.snapHeight,
    super.parent,
  });

  final double snapHeight;

  @override
  IntroSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return IntroSnapScrollPhysics(
      snapHeight: snapHeight,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final double currentScroll = position.pixels;
    final double target;

    const double minVelocity = 50;

    if (velocity.abs() < minVelocity) {
      target = (currentScroll / snapHeight).round() * snapHeight;
    } else if (velocity > 0) {
      target = ((currentScroll / snapHeight).ceil()) * snapHeight;
    } else {
      target = ((currentScroll / snapHeight).floor()) * snapHeight;
    }

    if (target != currentScroll) {
      return ScrollSpringSimulation(
        spring,
        currentScroll,
        target,
        velocity,
        tolerance: toleranceFor(position),
      );
    }

    return null;
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }
}
