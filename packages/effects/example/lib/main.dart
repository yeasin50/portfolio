import 'package:effects/effects.dart';
import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        extensions: [
          eff.EffectThemeExt.dark,
        ],
      ),
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<int> selectedItem = [];

  Offset shadowOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ShadowTextEffect(
            text: "Md Yeasin Sheikh",
            shadowColor: Colors.white,
            style: TextStyle(
              fontSize: 56,
            ),
          ),
        ),
      ),
    );
  }
}
