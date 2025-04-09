import 'package:flutter/material.dart';

///  create a simple chip widget to show checkBox at first when it is active
///  and [label] text with [labelStyle], default textStyle is body
///
/// ```dart
/// import 'package:effects/effects.dart' as eff;
///
/// eff.FilterChip(
/// label: "Tab $i",
/// isActive: selectedItem.contains(i),
/// activeColor: Colors.blue.withAlpha(100),
/// inActiveColor: Colors.grey.withAlpha(100),
/// onTap: () {
///   selectedItem.contains(i)
///       ? selectedItem.remove(i)
///       : selectedItem.add(i);
///   setState(() {});
/// },
/// ),
/// ```
class FilterChip extends StatefulWidget {
  const FilterChip({
    super.key,
    this.onTap,
    this.isActive = false,
    required this.label,
    required this.activeColor,
    required this.inActiveColor,
    this.labelStyle,
  });

  final bool isActive;
  final VoidCallback? onTap;

  final Color activeColor;
  final Color inActiveColor;

  final String label;
  final TextStyle? labelStyle;

  @override
  State<FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<FilterChip>
    with SingleTickerProviderStateMixin {
  ///
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.medium1,
  );

  void onTap() {
    if (widget.isActive) {
      controller.reverse();
    } else {
      controller.forward();
    }
    widget.onTap?.call();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isActive) controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isActive ? widget.activeColor : widget.inActiveColor,
      elevation: widget.isActive ? 8 : 0,
      shadowColor: widget.isActive ? widget.activeColor : widget.inActiveColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: !widget.isActive
              ? widget.inActiveColor.withAlpha(100)
              : widget.activeColor,
          width: widget.isActive ? 1 : .5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 16,
            top: 6,
            bottom: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Icon(
                    Icons.check,
                    size: 18 * controller.value,
                    color: widget.labelStyle?.color,
                  );
                },
              ),
              Text(
                widget.label,
                style: widget.labelStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
