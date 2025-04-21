import 'dart:ui';

import 'package:flutter/material.dart';

class RipplePage<T> extends Page<T> {
  const RipplePage({
    required this.builder,
    required this.color,
    required this.center,
    this.popPosition,
    this.duration = Durations.medium4,
    this.popDuration = Durations.medium1,
  });

  /// Page builder
  final WidgetBuilder builder;

  /// this use `barrierColor` and as well on radial circle
  /// use the background color of your destination page
  final Color color;

  /// animation start point/push
  final FractionalOffset center;

  /// pop page position, default is [center]
  final FractionalOffset? popPosition;

  /// push duration
  final Duration duration;

  /// pop duration
  final Duration popDuration;

  @override
  Route<T> createRoute(BuildContext context) {
    return RippleRoute(
      builder: builder,
      color: color,
      center: center,
      popPosition: popPosition,
    );
  }
}

/// Ripple page transition based [center]
/// More like circle expanding
///
/// ```dart
/// final route = eff.RippleRoute(
///   allowSnapshotting: true,
///   center: FractionalOffset.center,
///   popPosition: FractionalOffset.center,
///   color: Colors.white,
///   builder: (context) => Scaffold(
///     backgroundColor: Colors.black,
///     appBar: AppBar(),
///     body: Center(
///       child: BackButton(),
///     ),
///   ),
/// );
///
/// Navigator.of(context).push(route);
///```
///
class RippleRoute<T> extends PageRoute<T> {
  RippleRoute({
    required this.builder,
    super.settings,
    super.requestFocus,
    super.barrierDismissible = false,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
    this.color = Colors.white,
    required this.center,
    required this.popPosition,
    this.duration = Durations.medium4,
    this.popDuration = Durations.medium1,
  });

  /// Page builder
  final WidgetBuilder builder;

  /// this use [barrierColor] and as well on radial circle
  /// use the background color of your destination page
  final Color color;

  /// animation start point/push
  final FractionalOffset center;

  /// pop page position, default is [center]
  final FractionalOffset? popPosition;

  /// push duration
  final Duration duration;

  /// pop duration
  final Duration popDuration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    bool isPop = animation.status == AnimationStatus.reverse;

    return ShaderMask(
      shaderCallback: (rect) {
        return RadialGradient(
          radius: animation.value * 2,
          colors: [
            color,
            color.withAlpha(10),
          ],
          stops: [
            lerpDouble(0, 1, animation.value)!,
            1,
          ],
          center: isPop ? popPosition ?? center : center,
        ).createShader(rect);
      },
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Duration get reverseTransitionDuration => popDuration;

  @override
  Color? get barrierColor => null;

  @override
  bool get opaque => false;

  @override
  String? get barrierLabel => null;
}
