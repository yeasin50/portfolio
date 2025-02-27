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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: eff.SphereFlow(
        children: [
          ...List.generate(
            5,
            (i) => eff.SphereView(
              key: ValueKey("sphere $i"),
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: Text(
                  "Hey",
                  style: TextStyle(
                    fontSize: 55,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
 // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: ShadowTextEffect(
          //     text: "Md Yeasin Sheikh",
          //     shadowColor: Colors.white,
          //     style: TextStyle(
          //       fontSize: 56,
          //     ),
          //   ),
          // ),