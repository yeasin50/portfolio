import 'package:flutter/material.dart';

import '../../skill.dart';

class SkillChip extends StatefulWidget {
  const SkillChip({
    super.key,
    required this.skill,
  });
  final Skill skill;
  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  ///
  late final Skill skill = widget.skill;

  late final AnimationController controller =
      AnimationController(vsync: this, duration: Durations.short4);

  void forward(_) {
    controller.forward();
  }

  void reverse(_) {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SkillThemeExt>()!;
    return MouseRegion(
      onEnter: forward,
      onExit: reverse,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: theme.backgroundColor,
                stops: List.generate(
                  theme.backgroundColor.length,
                  (index) {
                    return index * 1 - controller.value;
                  },
                ),
              ),
            ),
            child: Tooltip(
              message: skill.description ?? "",
              textStyle: theme.descriptionTextStyle,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: theme.backgroundColor,
                ),
              ),
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(12),
              child: child!,
            ),
          );
        },
        child: InkWell(
          customBorder: StadiumBorder(),
          //   //todo: expand tree skill
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              skill.name,
              style: theme.labelTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
