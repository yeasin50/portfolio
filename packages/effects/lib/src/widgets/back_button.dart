import 'package:effects/effects.dart';
import 'package:flutter/material.dart';


@Deprecated("Might remove in Future. Or replace AnimatedArrowView with something cool here")
class AnimatedBackButton extends StatefulWidget {
  const AnimatedBackButton({
    super.key,
    this.onTap,
    this.backgroundColor = Colors.blueGrey,
    this.bulletColor = const Color.fromARGB(82, 255, 255, 255),
    required this.child,
  });

  final VoidCallback? onTap;
  final Widget child;
  final Color backgroundColor;
  final Color bulletColor;

  @override
  State<AnimatedBackButton> createState() => _AnimatedBackButtonState();
}

class _AnimatedBackButtonState extends State<AnimatedBackButton>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: Durations.medium1,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: ValueKey("value"),
      animation: animationController,
      builder: (context, child) => InkWell(
        onTap: widget.onTap,
        child: RotatedBox(
          quarterTurns: 2,
          child: AnimatedArrowView(
            backgroundColor: widget.backgroundColor,
            bulletColor: widget.bulletColor,
            child: RotatedBox(
              quarterTurns: 2,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
