import 'package:flutter/material.dart';
import 'package:skill/skill.dart';

class SkillItems extends StatelessWidget {
  const SkillItems({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Skill> skill = [
      Skill(
        name: "Fluter",
        description: "Build app for any device......",
      ),
      Skill(
        name: "Bloc",
        subItems: [
          Skill(name: "Ta"),
          Skill(name: "Da"),
        ],
      ),
      Skill(
        name: "Go Router",
      ),
      Skill(name: "Melos"),
      Skill(name: "Animation"),
      // ....
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: skill
                .map(
                  (e) => SkillChip(skill: e),
                )
                .toList())
      ],
    );
  }
}
