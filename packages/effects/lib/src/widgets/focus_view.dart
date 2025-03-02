import 'package:flutter/material.dart';

/// increase scale 1.2 on hover/OrPressed
///
/// ```dart
/// eff.FocusView(
///   child: SizedBox(
///     height: 64,
///     child: Text("title $index"),
///   ),
/// ),
/// ```
///
class FocusView extends StatefulWidget {
  const FocusView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<FocusView> createState() => _FocusViewState();
}

class _FocusViewState extends State<FocusView> {
  bool isFocused = false;

  void forward(_) {
    isFocused = true;
    setState(() {});
  }

  void reverse(_) {
    isFocused = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: forward,
      onExit: reverse,
      child: GestureDetector(
        onTapDown: forward,
        onTapUp: reverse,
        child: AnimatedScale(
          alignment: Alignment.centerLeft,
          scale: isFocused ? 1.2 : 1,
          duration: Durations.short3,
          child: widget.child,
        ),
      ),
    );
  }
}
