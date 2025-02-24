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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            FilterChip(
              label: Text("Asd"),
              selected: selectedItem.contains(-1),
              onSelected: (value) {
                selectedItem.contains(-1)
                    ? selectedItem.remove(-1)
                    : selectedItem.add(-1);
                setState(() {});
              },
            ),
            for (int i = 0; i < 7; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: eff.FilterChip(
                  label: "Tab $i",
                  isActive: selectedItem.contains(i),
                  activeColor: Colors.blue.withAlpha(100),
                  inActiveColor: Colors.grey.withAlpha(100),
                  onTap: () {
                    selectedItem.contains(i)
                        ? selectedItem.remove(i)
                        : selectedItem.add(i);
                    setState(() {});
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
