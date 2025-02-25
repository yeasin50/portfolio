import 'package:flutter/material.dart';

import '../../effects.dart';

/// shows shadow opposite of the mouse,
/// colors and blur fade is proportional to the distance of mouse
///
class ShadowTextEffect extends StatefulWidget {
  const ShadowTextEffect({
    super.key,
    required this.text,
    this.style,
    required this.shadowColor,
  });

  final String text;
  final TextStyle? style;
  final Color shadowColor;

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

  void onMouseMovement(Offset position) {
    if (_textWidgetPosition == null) return;

    Offset direction = _textWidgetPosition! - position;
    double distance = direction.distance;

    shadowOffset = direction / 10;
    blurRadius = distance / 20;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      key: _textKey,
      style: widget.style?.copyWith(
        shadows: [
          Shadow(
            color: widget.shadowColor,
            offset: shadowOffset,
            blurRadius: blurRadius,
          )
        ],
      ),
    );
  }
}
