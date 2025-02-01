import 'package:flutter/material.dart';

import 'package:stackoverflow_stats/stackoverflow_stats.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApp(),
      theme: ThemeData.dark().copyWith(
        extensions: [
          StackOverflowTheme.darkTheme(),
          // StackOverflowTheme.dayTheme(),
        ],
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const int userId = 10157127;

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: SoProfileView(userId: userId)),
            SizedBox(height: 32),
            BadgesCard(
              userId: userId,
              maxPreview: (null, null, null),
            ),
          ],
        ),
      ),
    );
  }
}
