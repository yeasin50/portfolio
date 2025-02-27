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
      backgroundColor: Colors.white,
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            final route = eff.RippleRoute(
              allowSnapshotting: true,
              center: FractionalOffset.center,
              popPosition: FractionalOffset.center,
              color: Colors.white,
              builder: (context) => Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(),
                body: Center(
                  child: BackButton(),
                ),
              ),
            );

            Navigator.of(context).push(route);
          },
        ),
      ),
      //  eff.SphereFlow(
      //   children: [
      //     ...List.generate(
      //       5,
      //       (i) => eff.SphereView(
      //         key: ValueKey("sphere $i"),
      //         child: Padding(
      //           padding: const EdgeInsets.all(38.0),
      //           child: Text(
      //             "Hey",
      //             style: TextStyle(
      //               fontSize: 55,
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
