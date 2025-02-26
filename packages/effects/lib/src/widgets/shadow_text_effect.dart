import 'dart:ui';

import 'package:flutter/material.dart';

import '../../effects.dart';

/// shows shadow opposite of the mouse,
/// colors and blur fade is proportional to the distance of mouse
///
/// - [maxShadowDistance] handles the shadow distance
///
class ShadowTextEffect extends StatefulWidget {
  const ShadowTextEffect({
    super.key,
    required this.text,
    this.style,
    required this.shadowColor,
    this.maxShadowDistance,
  });

  final String text;
  final TextStyle? style;
  final Color shadowColor;

  /// max blur distance from the actual  position
  /// if null then  it gonna use [style] fontSize->height
  ///
  final double? maxShadowDistance;

  @override
  State<ShadowTextEffect> createState() => _ShadowTextEffectState();
}

class _ShadowTextEffectState extends State<ShadowTextEffect>
    with MouseTrackerMixin {
  ///
  final GlobalKey _textKey = GlobalKey();

  Offset? _textWidgetPosition;
  void findTextWidgetPosition() {
    final RenderBox? box =
        _textKey.currentContext?.findRenderObject() as RenderBox?;

    _textWidgetPosition = box?.localToGlobal(Offset.zero);
    if (_textWidgetPosition == null) return;

    bool isLTR = Directionality.of(context) == TextDirection.ltr;

    //TODO: use renderBox instead of center
    ///  bounds = _textWidgetPosition & box!.size
    ///
    _textWidgetPosition = Offset(
      _textWidgetPosition!.dx + (box!.size.width / 2 * (isLTR ? 1 : -1)),
      _textWidgetPosition!.dy + (box.size.height / 2 * (isLTR ? 1 : -1)),
    );
  }

  @override
  void initState() {
    super.initState();

    onMouseMove = onMouseMovement;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      findTextWidgetPosition();
    });
  }

  Offset shadowOffset = Offset.zero;
  double blurRadius = 0;

  late final double maxShadowDistance = widget.maxShadowDistance ??
      (widget.style?.fontSize ??
              Theme.of(context).textTheme.bodyMedium?.fontSize ??
              14) *
          2;

  late TextStyle? style = widget.style;

  double lerpFactor = 1;

  void onMouseMovement(Offset position) {
    if (_textWidgetPosition == null) return;

    Offset direction = _textWidgetPosition! - position;
    double distance = direction.distance;

    if (distance == 0) return;

    Offset normalizedDirection = direction / distance;
    lerpFactor = (distance / 100).clamp(0, 1);

    double scaledDistance = lerpDouble(0, maxShadowDistance, lerpFactor)!;
    shadowOffset = normalizedDirection * scaledDistance;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      key: _textKey,
      style: style?.copyWith(
        shadows: [
          Shadow(
            color: widget.shadowColor.withAlpha(
              lerpDouble(0, 150, lerpFactor)!.toInt(),
            ),
            offset: shadowOffset,
            blurRadius: lerpDouble(120, 0, lerpFactor)!,
          )
        ],
      ),
    );
  }
}
