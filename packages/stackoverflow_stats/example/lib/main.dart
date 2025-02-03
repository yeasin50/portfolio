import 'package:flutter/material.dart';

import 'package:stackoverflow_stats/stackoverflow_stats.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApp(),

      //     SoPageView(
      //   userId: 10157127,
      // ),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SoProfileView(
            userId: userId,
          ),
          SizedBox(height: 32),
          // BadgesCard(
          //   userId: userId,
          //   maxPreview: (null, null, null),
          // ),
        ],
      ),
    );
  }
}
