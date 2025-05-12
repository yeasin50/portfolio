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
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: AdvanceRichText(
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            ),
            hoverTextStyle: TextStyle(
              color: Colors.greenAccent,
              fontSize: 32,
            ),
            data: [
              TextSpanData(text: "Enjoy solving bugs and helping others."),
              TextSpanData(text: " Ranked #2 in August 2022", url: "asd"),
              TextSpanData(
                  text: "  Mostly contribute to Flutter and Dart, with "),
              TextSpanData(text: "gold badges as recognition.", url: "asd"),
            ],
          ),
        ),
      ),
    );
  }
}
