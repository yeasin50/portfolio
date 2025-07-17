
import 'package:flutter/material.dart';

///  this will be animated button,
///  will show the current timezone of the viewer,(BST)
/// on Hover it will expand and show the full details.(Bangladesh Standard Time)
class TimeZoneChip extends StatefulWidget {
  const TimeZoneChip({
    super.key,
    this.backGroundColor = const Color(0xFF18FFFF),
  });

  final Color backGroundColor;
  @override
  State<TimeZoneChip> createState() => _TimeZoneChipState();
}

class _TimeZoneChipState extends State<TimeZoneChip>
    with SingleTickerProviderStateMixin {
  final String baseTimezone = "BST";
  final String exapndTimeZone = "Bangladesh Standard Time";

  late final controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
    lowerBound: baseTimezone.length.toDouble(),
    upperBound: exapndTimeZone.length.toDouble(),
  );

  late String previewString = baseTimezone;

  bool isHovered = false;
  void onHover(bool v) {
    isHovered = v;
    isHovered ? controller.forward() : controller.reverse();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontSize: 32);
    return Material(
      color: widget.backGroundColor,
      shape: StadiumBorder(),
      child: InkWell(
        onTap: () {
          if (controller.isCompleted)
            controller.reverse();
          else
            controller.forward();
        },
        onHover: onHover,
        customBorder: StadiumBorder(
          side: BorderSide(color: widget.backGroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: textStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Timezone:"),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    previewString =
                        controller.value == baseTimezone.length
                            ? baseTimezone
                            : exapndTimeZone.substring(
                              0,
                              controller.value.toInt(),
                            );
                    return Text(previewString, style: textStyle);
                  },
                ),
              ],
            ),
          ),
        ), //
      ),
    );
  }
}
