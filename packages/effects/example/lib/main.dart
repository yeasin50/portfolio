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
          const Color(0xFF1E2036),
          const Color(0xFF343C59),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Wrap(
          children: [
            eff.SphereView(),
            for (final c in eff.SpherePlasmaData.defaults)
              eff.PlasmaBallSphere(
                data: c,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(
                    child: Text(
                      "1231 asd",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
