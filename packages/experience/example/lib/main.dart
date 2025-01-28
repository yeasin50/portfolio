import 'package:core/core.dart';
import 'package:experience/experience.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        extensions: [
          ExperienceTheme.darkTheme(),
          // ExperienceTheme.dayTheme(),
        ],
      ),
      home: _Home(),
    ),
  );
}

class _Home extends StatefulWidget {
  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final items = List.generate(
    5,
    (index) => Experience(
      title: "Flutter Developer",
      company: Organization(name: "organization"),
      start: DateTime(2020),
      description:
          "Created x with boost performance 20% which increased revenue \$12B",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExperienceView(experiences: items),
    );
  }
}
