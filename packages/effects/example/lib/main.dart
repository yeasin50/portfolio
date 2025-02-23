import 'package:flutter/material.dart';
import 'package:effects/effects.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(extensions: [EffectThemeExt.dark]),
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
      body: Center(
        child: NeonButton(
          label: "See more",
          onTap: () {
            ///...
          },
        ),
      ),
    );
  }
}
