import 'package:flutter/material.dart';
import 'package:project/project.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = List.generate(5, (index) => Project.ui);
    return Scaffold(
      body: ListView.separated(
        itemCount: projects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (ct, i) => ProjectTile(
          project: projects[i],
          tileType: ProjectTileType.titleLarge,
        ),
      ),
    );
  }
}
