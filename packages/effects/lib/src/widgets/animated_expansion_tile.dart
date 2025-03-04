import 'package:effects/src/widgets/animated_expansion_icon.dart';
import 'package:flutter/material.dart';

/// animation Expansion tile with drop shader
///
///```dart
/// eff.AnimatedExpansionTile(
///   title: Text("Expansion title"),
///   initialExpanded: true,
///   lowerBound: .5,
///   children: [
///     for (final t in eff.BulletType.values)
///       eff.BulletItemView(
///         type: t,
///         child: SizedBox(
///           height: 64,
///           child: Text(" ${t.name} "),
///         ),
///       ),
///   ],
/// ),
/// ```
///
class AnimatedExpansionTile extends StatefulWidget {
  const AnimatedExpansionTile({
    this.lowerBound,
    super.key,
    required this.title,
    required this.children,
    this.duration = Durations.medium3,
    this.initialExpanded = false,
  });

  final Widget title;
  final List<Widget> children;

  final Duration duration;

  final bool initialExpanded;

  /// initial visible offset 0-1
  /// if null, it will use use approximate  1st 3 of [children]
  final double? lowerBound;

  @override
  State<AnimatedExpansionTile> createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  late bool isExpanded = widget.initialExpanded;

  late double lowerBound;
  @override
  void initState() {
    super.initState();
    assert(
      widget.lowerBound == null ||
          (widget.lowerBound! >= 0 && widget.lowerBound! <= 1),
      "lowerBound should be between 0 and 1",
    );

    lowerBound = widget.lowerBound ??
        //FIXME: seems I need to move on px instead of relative HeightFractor
        (widget.children.length > 3 ? .3 : 0.0).clamp(0.0, 1.0);

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: lowerBound,
    );
    if (widget.initialExpanded) controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onTap() {
    isExpanded ? controller.reverse() : controller.forward();
    isExpanded = !isExpanded;
    setState(() {});
  }

  void onLongPress() {
    if (isExpanded) return;
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
            child: Row(
              children: [
                Expanded(child: widget.title),
                AnimatedExpansionIcon(isExpanded: isExpanded),
              ],
            ),
          ),
        ),
        GestureDetector(
          onLongPress: onLongPress,
          onTap: onLongPress,
          child: ClipRRect(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                final colorStops = [
                  (controller.value - lowerBound) / (1 - lowerBound),
                  1.0,
                ];

                return ShaderMask(
                  blendMode: BlendMode.dstOut,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [Colors.transparent, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: colorStops,
                    ).createShader(bounds);
                  },
                  child: Align(
                    heightFactor: controller.value,
                    alignment: Alignment.topCenter,
                    child: child!,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: widget.children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
