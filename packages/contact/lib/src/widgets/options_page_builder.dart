import 'dart:math';

import 'package:contact/src/widgets/option_view.dart';
import 'package:flutter/material.dart';

import '../utils/option_info.dart';

class OptionsPageBuilder extends StatefulWidget {
  const OptionsPageBuilder({
    super.key,
    required this.title,
    required this.description,
    required this.options,
  });

  ///  question
  final String title;

  /// a
  final String description;

  /// gonna hang on  questions[title]
  final List<OptionInfo> options;

  @override
  State<OptionsPageBuilder> createState() => _OptionsPageBuilderState();
}

class _OptionsPageBuilderState extends State<OptionsPageBuilder>
    with TickerProviderStateMixin {
  ///
  Offset mousePosition = Offset.zero;

  ///start animation
  late AnimationController startController;

  @override
  void initState() {
    super.initState();
    startController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        child: Center(
          child: Flow(
            delegate: OptionsFlowDelegate(
              mousePosition: mousePosition,
            ),
            children: [
              for (int i = 0; i < widget.options.length; i++) ...[
                OptionView(
                  option: widget.options[i],
                  onTap: () {},
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsFlowDelegate extends FlowDelegate {
  const OptionsFlowDelegate({
    required this.mousePosition,
  });

  final Offset mousePosition;

  @override
  void paintChildren(FlowPaintingContext context) {
    final center = Offset(context.size.width / 2, context.size.height / 2);

    List<Offset> childrenOffset = [];

    final horizontalSpacing = context.size.width / (context.childCount + 1);
    final childScale = 1 / context.childCount / 2;

    for (int i = 0; i < context.childCount; i++) {
      final xPosition = (i + 1) * horizontalSpacing;
      final frequency = 2 * pi / context.childCount;
      final amplitude = 150.0;
      final yPosition = center.dy + amplitude * sin(frequency * i);
      childrenOffset.add(Offset(xPosition, yPosition));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(xPosition, yPosition)
          ..scale(childScale),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false; // Only repaint when needed
  }
}
