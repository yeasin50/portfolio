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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SkillThemeExt>()!;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(colors: theme.backgroundColor),
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
        margin: EdgeInsets.all(32),
        padding: EdgeInsets.all(12),
        child: InkWell(
          customBorder: StadiumBorder(),
          onTap: () {
            //
            //todo: expand tree skill
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
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
