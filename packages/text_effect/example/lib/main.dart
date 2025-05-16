import 'package:flutter/material.dart';

import 'package:text_effect/text_effect.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///
  final data = [
    ParagraphData(text: "Enjoy solving bugs and helping others."),
    ParagraphData(text: " Ranked #2 in August 2022", url: "asd"),
    ParagraphData(text: "  Mostly contribute to Flutter and Dart, with "),
    ParagraphData(text: "gold badges as recognition.", url: "asd", bold: true),
  ];

  final style = TextStyle(
    color: Colors.black,
    fontSize: 32,
  );

  final hoverStyle = TextStyle(
    color: Colors.greenAccent,
    fontSize: 32,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextSwitcher(
              primaryText: "primaryText will be little long huhahaha",
              secondaryText: "secondaryText",
              primaryTextStyle: style,
              onInit: (ctrl) {
                ctrl.forward();
              },
            ),
            const SizedBox(height: 32),
            AdvanceRichText(
              style: style,
              hoverTextStyle: hoverStyle,
              data: data,
            ),
            const SizedBox(height: 32),
            ParagraphPainter(
              style: style,
              hoverTextStyle: hoverStyle,
              data: data,
            )
          ],
        ),
      ),
    );
  }
}
