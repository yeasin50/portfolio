import 'package:flutter/material.dart';
import 'package:skill/skill.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApp(),
      theme: ThemeData.light().copyWith(extensions: [
        SkillThemeExt.darkTheme(),
      ]),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Skill skill = Skill(
      name: "Fluter",
      description: "Build app for any device......" * 13,
      subItems: [
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
      ],
    );
    return Scaffold(
      body: Center(
        child: SkillChip(
          skill: skill,
        ),
      ),
    );
  }
}
