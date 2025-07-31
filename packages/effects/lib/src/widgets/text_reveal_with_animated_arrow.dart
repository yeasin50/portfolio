part of 'animated_arrow_view.dart';

///  create simple animated Arrow bullet point and next to the
/// ```dart
/// eff.TextRevealWithArrow(
///      label: availableStr,
///      primaryTextStyle:
///          theme.tldr.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
///      hoverTextStyle:
///          theme.tldr.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
///    )
/// ```
class TextRevealWithArrow extends StatefulWidget {
  const TextRevealWithArrow({
    super.key,
    required this.label,
    required this.primaryTextStyle,
    required this.hoverTextStyle,
    this.duration = Durations.long3,
    this.backgroundColor,
    this.bulletColor,
    this.initialAnimationValue = 0,
  });

  final String label;

  /// without hover/ not reveal textStyle
  final TextStyle primaryTextStyle;
  final TextStyle hoverTextStyle;

  final Duration duration;

  final double initialAnimationValue;

  /// if null it will use [EffectThemeExt]' s card color
  ///
  final Color? backgroundColor;

  /// if null it will use [EffectThemeExt]' s glow color
  ///
  final Color? bulletColor;

  @override
  State<TextRevealWithArrow> createState() => _TextRevealWithArrowState();
}

class _TextRevealWithArrowState extends State<TextRevealWithArrow>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final AnimationController rippleController;

  @override
  void initState() {
    super.initState();
    assert(
        widget.initialAnimationValue >= 0 &&
            widget.initialAnimationValue <= 1.0,
        "initialAnimationValue should be withing 0-1");

    rippleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(
        () {
          if (controller.isCompleted) {
            rippleController.animateBack(1);
          } else {
            rippleController.repeat();
          }
        },
      );
    controller.value = widget.initialAnimationValue;
  }

  void onForward(_) {
    controller.forward();
  }

  void onExit(_) {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    final theme = themeContext.extension<EffectThemeExt>()!;

    return MouseRegion(
      onEnter: onForward,
      onExit: onExit,
      child: AnimatedBuilder(
        animation: Listenable.merge([controller, rippleController]),
        builder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: widget.backgroundColor ?? theme.cardColor.first,
                shape: _ArrowShapeBuilder(
                  animation: controller,
                  rippleAnimation: rippleController,
                  color: widget.bulletColor ?? theme.glowColor,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: lerpDouble(42, 16, controller.value)!,
                  top: 6,
                  bottom: 6,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    child!,
                    ClipPath(
                      clipper: RevealClipPath(controller),
                      child: Text(
                        widget.label,
                        style: widget.hoverTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          widget.label,
          style: widget.primaryTextStyle,
        ),
      ),
    );
  }
}

/// Reveal widgets from  Left to right
class RevealClipPath extends CustomClipper<Path> {
  RevealClipPath(this.animation) : super(reclip: animation);
  final Animation animation;

  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTRB(0, 0, size.width * animation.value, size.height));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
