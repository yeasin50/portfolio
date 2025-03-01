import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;
import 'package:portfolio_yeasin/src/presentation/connect/widgets/hr_connect_page.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});
  static String route = "/connect/hr";

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  //

  Offset tapPosition = Offset.zero;

  void onTap(String item) {
    final size = MediaQuery.sizeOf(context);
    final pushPosition = FractionalOffset.fromOffsetAndSize(tapPosition, size);
    final route = eff.RippleRoute(
      builder: (context) => const HrConnectPage(),
      center: pushPosition,
      duration: Duration(seconds: 1),
      popPosition: pushPosition,
      color: Colors.blueAccent,
    );
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: eff.SphereFlow(
              children: [
                ...["Project", "HR", "Scholarship"].map(
                  (e) => GestureDetector(
                    onPanDown: (details) {
                      tapPosition = details.globalPosition;
                    },
                    onTap: () => onTap(e),
                    child: eff.SphereView(
                      key: ValueKey("flowItem $e"),
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Text(e),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
