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

  final IConnectRepo data;
  static route({
    required IConnectRepo data,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ConnectPage(data: data),
    );
  }

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  //

  void onTap(ConnectOption item, FractionalOffset pushPosition) {
    final route = ConnectOptionPage.route(
        option: item,
        animateTO: pushPosition,
        primaryColor: Colors.white,
        pushDuration: Durations.extralong1);
    Navigator.of(context).push(route);
  }

  List<Offset> childrenOffset = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return eff.BackgroundView(
      colors: [
        Color.fromARGB(255, 30, 32, 54),
        Color.fromARGB(255, 52, 60, 89),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: eff.SphereFlow(
                  callback: (childPosition) {
                    childrenOffset = childPosition;
                  },
                  children: [
                    for (int i = 0; i < widget.data.items.length; i++)
                      GestureDetector(
                        onPanDown: (details) {},
                        onTap: () {
                          final pushPosition =
                              FractionalOffset.fromOffsetAndSize(
                                  childrenOffset[i], size);

                          onTap(widget.data.items[i], pushPosition);
                        },
                        child: eff.SphereView(
                          key:
                              ValueKey("flowItem ${widget.data.items[i].name}"),
                          child: Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Text(
                              widget.data.items[i].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Center(
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => Navigator.of(context).pop(),
                child: eff.SphereView(
                  colors: [Colors.white, Colors.transparent],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
