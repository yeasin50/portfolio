import 'package:example/sine_wave_effect.dart';
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
  double anim = 0;

  void testRoute(Offset offset) {
    final size = MediaQuery.sizeOf(context);
    final pushPosition = FractionalOffset.fromOffsetAndSize(offset, size);

    Navigator.of(context).push(eff.RippleRoute(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: ListView.builder(
            itemBuilder: (context, index) => ListTile(
              tileColor: Colors.primaries[index % Colors.primaries.length],
              title: Text("data $index"),
            ),
          ),
        );
      },
      color: Colors.white,
      center: FractionalOffset.center,
      popPosition: pushPosition,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onPanDown: (details) {
          testRoute(details.globalPosition);
        },
        child: Text("data"),
      ),
    ));
  }
}
