import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        extensions: [
          eff.EffectThemeExt.dark,
        ],
      ),
      home: eff.BackgroundView(
        shaderPath: "shaders/bg_shader.frag",
        colors: [
          const Color(0xFF343C59),
          const Color(0xFF1E2036),
          // Colors.black,
          // Colors.white,
        ],
        child: Home(),
      ),
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
          body: Center(),
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
        child: Placeholder(),
        // child: InteractiveViewer(
        // maxScale: 200,
        // child: eff.GoldenSpiralRecursive(
        //   children: List.generate(
        //     12,
        //     (index) => Text(index.toString()),
        //   ),
        // ),
        // ),
      ),
    );
  }
}
