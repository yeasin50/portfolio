import 'package:effects/src/utils/mouse_tracker_mixin.dart';
import 'package:flutter/material.dart';

/// just image little transform
@Deprecated("under construction ")
class ParallaxEffect extends StatefulWidget {
  const ParallaxEffect({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ParallaxEffect> createState() => _ParallaxEffectState();
}

class _ParallaxEffectState extends State<ParallaxEffect>
    with MouseTrackerMixin {
  @override
  void initState() {
    super.initState();
    onMouseMove = onChanged();
  }

  onChanged() {
    setState(() {});
  }

  bool defaultPosition = true;
  double get percentageX => (mousePosition.dx / (222)) * 100;
  double get percentageY => (mousePosition.dy / 230) * 100;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
        ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
      alignment: FractionalOffset.center,
      child: widget.child,
    );
  }
}
