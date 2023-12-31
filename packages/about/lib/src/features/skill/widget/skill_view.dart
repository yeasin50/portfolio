import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

import '../models/skill.dart';

class SkillView extends StatelessWidget {
  const SkillView({
    Key? key,
    required this.skill,
  }) : super(key: key);

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill.type,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        8.verticalSpacer,
        ...skill.values.map((skill) => Text(skill)).toList(),
      ],
    );
  }
}
