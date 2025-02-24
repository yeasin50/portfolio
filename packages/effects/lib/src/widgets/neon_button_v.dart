import 'package:flutter/material.dart';

import '../../effects.dart';

///  simple cool button with effects,
/// [label] to show text
///
///  ```dart
///   NeonButton(
///       label: "See more",
///       onTap: () {...},
///   )
/// ```
class NeonButton extends StatefulWidget {
  const NeonButton({
    super.key,
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<EffectThemeExt>()!;

    return MouseRegion(
      onEnter: (event) {
        isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        isHovered = false;
        setState(() {});
      },
      child: AnimatedScale(
        duration: Durations.short3,
        scale: isHovered ? 1.075 : 1,
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: theme.neonButtonStyle,
          child: Text(
            widget.label,
          ),
        ),
      ),
    );
  }
}
