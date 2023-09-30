import 'package:flutter/material.dart';

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
        Text(skill.type),
        ...skill.skills.map((skill) => Text(skill)).toList(),
      ],
    );
  }
}
