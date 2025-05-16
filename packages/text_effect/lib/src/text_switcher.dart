import 'package:flutter/material.dart';

///  return  animation controller on callback
///
typedef OnInit = void Function(AnimationController ctrl);

/// {@template textSwitcher}
/// switch [primaryText] to [secondaryText] if not null. use [onInit] to play/stop animation
///
/// Scale and fade out [primaryText] and scale, fade and slide [secondaryText]
///
///- [primaryTextStyle] for [primaryText]
///
///- [secondaryTextStyle] for [secondaryText], if null then  it use [primaryTextStyle]
///
///- [duration] animation duration, default is [Durations.medium1]
///
///- [animationValue] go to specific animation
///
/// {@endtemplate}
///
/// {@tool snippet}
/// Example
/// ```dart
/// TextSwitcher(
///  primaryText: "primaryText will be little long huhahaha",
///  secondaryText: "secondaryText",
///  primaryTextStyle: style,
///  onInit: (ctrl) {
///    ctrl.forward();
///  })
/// ```
/// {@end-tool}
///
class TextSwitcher extends StatefulWidget {
  /// {@macro textSwitcher}
  const TextSwitcher({
    super.key,
    required this.primaryText,
    required this.primaryTextStyle,
    this.secondaryText,
    this.secondaryTextStyle,
    this.onInit,
    this.duration = Durations.medium1,
    this.animationValue = 0,
  }) : assert(animationValue <= 1 && animationValue >= 0,
            "animationValue must be within 0-1");

  final String primaryText;
  final TextStyle primaryTextStyle;

  final String? secondaryText;

  ///  if null use  [primaryTextStyle]
  final TextStyle? secondaryTextStyle;

  final OnInit? onInit;

  /// default animation duration  is [Durations.medium1]
  final Duration duration;

  /// animate to specific position
  final double animationValue;

  @override
  State<TextSwitcher> createState() => _TextSwitcherState();
}

class _TextSwitcherState extends State<TextSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    widget.onInit?.call(controller);
    controller.animateTo(widget.animationValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animationValue != widget.animationValue) {
      controller.animateTo(widget.animationValue);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: [
            FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(controller),
              child: Transform.scale(
                alignment: Alignment.center,
                scale: 1 - controller.value,
                child: child,
              ),
            ),
            if (widget.secondaryText != null)
              FadeTransition(
                opacity: Tween<double>(begin: -1, end: 1).animate(controller),
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(controller),
                  child: Transform.scale(
                    alignment: Alignment.center,
                    scale: controller.value,
                    child: Text(
                      widget.secondaryText!,
                      style:
                          widget.secondaryTextStyle ?? widget.primaryTextStyle,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: Text(
        widget.primaryText,
        style: widget.primaryTextStyle,
      ),
    );
  }
}
