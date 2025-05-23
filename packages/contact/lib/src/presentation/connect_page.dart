import 'package:contact/src/presentation/connect_body_mobile_view.dart';
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
class ConnectPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return eff.BackgroundView(
      colors: [
        Color.fromARGB(255, 30, 32, 54),
        Color.fromARGB(255, 52, 60, 89),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ConnectPageBody(
          data: data,
          onHomeIconTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

///  section shows connect-page body
/// this is part of [ConnectPage] just without scaffold
///
class ConnectPageBody extends StatefulWidget {
  const ConnectPageBody({
    super.key,
    required this.data,
    this.onHomeIconTap,
  });

  final IConnectRepo data;

  /// when  user tap  on [onHomeIconTap]
  final VoidCallback? onHomeIconTap;

  @override
  State<ConnectPageBody> createState() => _ConnectPageBodyState();
}

class _ConnectPageBodyState extends State<ConnectPageBody> {
  void onTap(
    ConnectOption item,
    FractionalOffset pushPosition,
    eff.SpherePlasmaData plasmData,
  ) {
    final route = ConnectOptionPage.route(
      option: item,
      animateTO: pushPosition,
      primaryColor: Colors.white,
      pushDuration: Durations.extralong1,
      plasmaData: plasmData,
    );
    Navigator.of(context).push(route);
  }

  List<Offset> childrenOffset = [];

  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController = PrimaryScrollController.maybeOf(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 550) {
      return ConnectBodyMobileView(
        data: widget.data,
      );
    }
    return Stack(
      clipBehavior: Clip.none,
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
                  () {
                    final plasmaData = eff.SpherePlasmaData
                        .defaults[i % eff.SpherePlasmaData.defaults.length];
                    return GestureDetector(
                      onPanDown: (details) {},
                      onTap: () {
                        final size = MediaQuery.sizeOf(context);
                        final pushPosition = FractionalOffset.fromOffsetAndSize(
                          childrenOffset[i],
                          size,
                        );

                        onTap(widget.data.items[i], pushPosition, plasmaData);
                      },
                      child: eff.PlasmaBallSphere(
                        key: ValueKey("flowItem ${widget.data.items[i].name}"),
                        data: plasmaData,
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(48.0),
                              child: Text(
                                widget.data.items[i].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }()
              ],
            ),
          ),
        ),
        if (widget.onHomeIconTap != null)
          Center(
            child: eff.HomeIcon(
              onTap: widget.onHomeIconTap,
            ),
          )
      ],
    );
  }
}
