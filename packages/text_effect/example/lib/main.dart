import 'package:flutter/material.dart';

import 'package:text_effect/text_effect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: Column(
          children: [
            CounterNumberEffect(
              value: 10,
              startValue: 0,
              duration: Duration(seconds: 10),
            ),
          ],
        ),
      ),
    );
  }
}
