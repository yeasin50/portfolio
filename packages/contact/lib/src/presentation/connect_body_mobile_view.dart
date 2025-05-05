import 'package:flutter/material.dart';
import 'package:effects/effects.dart' as eff;

import '../../contact.dart';

///!  So how would we like to show on mobile view?
///
/// ~ We can not make it vertical scrollable because we are already in it;
/// - yap,  we can make it horizontal  scrollable but
///   --  Does it look good ?
///   --  yes,  but will cost the user experience.
///  *  I am thinking let's just flow with vertical scrollable items
///
///

///  A horizontal  Connection options for [ConnectPage] or [ConnectPageBody]
///  when  we are in small screen
///
class ConnectBodyMobileView extends StatefulWidget {
  const ConnectBodyMobileView({
    super.key,
    required this.data,
    this.onHomeIconTap,
  });

  final IConnectRepo data;

  /// when  user tap  on [onHomeIconTap]
  final VoidCallback? onHomeIconTap;

  @override
  State<ConnectBodyMobileView> createState() => _ConnectBodyMobileViewState();
}

class _ConnectBodyMobileViewState extends State<ConnectBodyMobileView> {
  void onTap(
    ConnectOption item,
    FractionalOffset pushPosition,
    eff.SpherePlasmaData plasmaData,
  ) {
    final route = ConnectOptionPage.route(
      option: item,
      animateTO: pushPosition,
      primaryColor: Colors.white,
      pushDuration: Durations.extralong1,
      plasmaData: plasmaData,
    );
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 64,
          child: eff.HomeIcon(
            onTap: widget.onHomeIconTap,
          ),
        ),
        Center(
          child: Flow(
            delegate: _MobileViewFlowDelegate(),
            children: [
              for (int i = 0; i < widget.data.items.length; i++)
                GestureDetector(
                  onPanDown: (details) {},
                  onTap: () {
                    //NOT actual size, make sense while it is paint
                    // final size = MediaQuery.sizeOf(context);
                    // final pushPosition = FractionalOffset.fromOffsetAndSize(
                    //   childrenOffset[i], // we can't have it here :(
                    //   size,
                    // );

                    // onTap(widget.data.items[i], pushPosition);
                  },
                  child: eff.SphereView(
                    key: ValueKey("flowItem ${widget.data.items[i].name}"),
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
      ],
    );
  }
}

class _MobileViewFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = context.size.height;
    final cx = context.size.width / 2;

    for (int i = 0; i < context.childCount; i++) {
      final itemSize = context.getChildSize(i)!;
      dy -= itemSize.height * 2;

      double dx = cx - itemSize.width / 2;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
