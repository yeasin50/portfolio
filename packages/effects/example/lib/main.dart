import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;

import 'src/utils/shader_loader.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(58.0),
            child: Column(
              children: [
                eff.AnimatedExpansionTile(
                  title: Text("Expansion title"),
                  initialExpanded: true,
                  lowerBound: .5,
                  children: [
                    for (final t in eff.BulletType.values)
                      eff.BulletItemView(
                        type: t,
                        child: SizedBox(
                          height: 64,
                          child: Text(" ${t.name} "),
                        ),
                      ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
