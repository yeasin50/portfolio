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

  final colorCombos =
      <({Color coreColor, Color plasmaColor, Color outerColor})>[
    (
      coreColor: Color(0xFF8E24AA), // Rich Purple
      plasmaColor: Color(0xFF311B92), // Dark Violet-Blue
      outerColor: Color(0xFF1E2036), // Matches background
    ),
    (
      coreColor: Color(0xFF00BFA5), // Soft Teal Core
      plasmaColor: Color(0xFF00695C), // Dark Teal Plasma
      outerColor: Color(0xFF1E2036), // Background-blended
    ),
    (
      coreColor: Color(0xFF3949AB), // Indigo
      plasmaColor: Color(0xFF1A237E), // Deep Indigo
      outerColor: Color(0xFF2A2F4F), // Muted Blue-Grey
    ),
    (
      coreColor: Color(0xFFFF4081), // Hot Pink Core
      plasmaColor: Color(0xFFAD1457), // Raspberry Glow
      outerColor: Color(0xFF343C59), // Soft blend with background
    ),
    (
      coreColor: Color(0xFF00ACC1), // Bright Teal Core
      plasmaColor: Color(0xFF00796B), // Jungle Green Plasma
      outerColor: Color(0xFF2B2F44), // Faded Charcoal Blue
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Wrap(
          children: [
            eff.SphereView(),
            for (final item in colorCombos)
              eff.PlasmaBallSphere(
                coreColor: item.coreColor,
                plasmaColor: item.plasmaColor,
                outerColor: item.outerColor,
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
