import 'package:flutter/material.dart';

import 'package:text_effect/text_effect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      TextSpanData(text: "Enjoy solving bugs and helping others."),
      TextSpanData(text: " Ranked #2 in August 2022", url: "asd"),
      TextSpanData(text: "  Mostly contribute to Flutter and Dart, with "),
      TextSpanData(text: "gold badges as recognition.", url: "asd", bold: true),
    ];

    final style = TextStyle(
      color: Colors.black,
      fontSize: 32,
    );

    final hoverStyle = TextStyle(
      color: Colors.greenAccent,
      fontSize: 32,
    );

    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            children: [
              AdvanceRichText(
                style: style,
                hoverTextStyle: hoverStyle,
                data: data,
              ),
              const SizedBox(
                height: 32,
              ),
              ParagraphPainter(
                style: style,
                hoverTextStyle: hoverStyle,
                data: data,
              )
            ],
          ),
        ),
      ),
    );
  }
}
