import 'package:flutter/material.dart';
import 'package:skill/skill.dart';

/// Someday gonna have some time for it
class SkillItems extends StatelessWidget {
  const SkillItems({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Skill> skills = [
      Skill(
        name: "Flutter",
        subItems: [
          Skill(name: "BLoC"),
          Skill(name: "GoRouter"),
          Skill(name: "Animations"),
        ],
      ),
      Skill(
        name: "Go",
        subItems: [
          Skill(name: "REST APIs"),
          Skill(name: "Concurrency"),
          Skill(name: "HTMX"),
        ],
      ),
      Skill(
        name: "PostgreSQL",
        subItems: [Skill(name: "pgx")],
      ),
      Skill(name: "Docker"),
      Skill(name: "Neovim"),
      Skill(name: "Melos"),
      Skill(name: "Educational Video Creation"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: skills.map((e) => SkillChip(skill: e)).toList(),
        ),
      ],
    );
  }
}
