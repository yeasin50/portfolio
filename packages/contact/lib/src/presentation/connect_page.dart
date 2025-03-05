import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;
import '../../contact.dart';

///  entry  point of ConnectPage
/// show some sphere to choose from
///
/// have cool effect
/// -  navigate to the details page [ConnectOptionPage]
/// *  required [IConnectRepo] class implementation  on parent widget
///
class ConnectPage extends StatefulWidget {
  const ConnectPage({
    super.key,
    required this.data,
  });
  static String route = "/connect/hr";

  final IConnectRepo data;

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  //

  Offset tapPosition = Offset.zero;

  void onTap(ConnectOption item) {
    final size = MediaQuery.sizeOf(context);
    final pushPosition = FractionalOffset.fromOffsetAndSize(tapPosition, size);
    final route = ConnectOptionPage.route(
      option: item,
      animateTO: pushPosition,
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
                ...widget.data.items.map(
                  (e) => GestureDetector(
                    onPanDown: (details) {
                      tapPosition = details.globalPosition;
                    },
                    onTap: () => onTap(e),
                    child: eff.SphereView(
                      key: ValueKey("flowItem ${e.name}"),
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Text(e.name),
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
