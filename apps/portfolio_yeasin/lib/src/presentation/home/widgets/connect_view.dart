import 'package:flutter/material.dart';

import 'connects_flow_delegate.dart';

///  some professional  profiles for portfolio
/// *  returns a [CustomMultiChildLayout] need to make sure
class ConnectView extends StatefulWidget {
  const ConnectView({super.key});

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView>
    with TickerProviderStateMixin {
  void init() {}

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: ConnectMultiChildDelegate(),
      children: [
        LayoutId(
          id: 0,
          child: _ConnectButton(
            icon: const Icon(
              Icons.abc,
              color: Colors.grey,
            ),
            onHovered: (value) {},
            onTap: () {},
          ),
        ),
        LayoutId(
            id: 1,
            child: _ConnectButton(
              icon: const Icon(
                Icons.ac_unit_outlined,
                color: Colors.grey,
              ),
              onHovered: (value) {},
              onTap: () {},
            )),
        LayoutId(
          id: 2,
          child: _ConnectButton(
            icon: const Icon(
              Icons.access_alarms_sharp,
              color: Colors.grey,
            ),
            onHovered: (value) {},
            onTap: () {},
          ),
        ),
        LayoutId(
            id: 3,
            child: _ConnectButton(
              icon: const Icon(
                Icons.account_tree_sharp,
                color: Colors.grey,
              ),
              onHovered: (value) {},
              onTap: () {},
            )),
      ],
    );
  }
}

class _ConnectButton extends StatefulWidget {
  const _ConnectButton({
    required this.icon,
    required this.onHovered,
    required this.onTap,
  });
  final Widget icon;
  final ValueChanged<bool> onHovered;
  final VoidCallback onTap;

  @override
  State<_ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<_ConnectButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white10, width: 1),
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        onHover: widget.onHovered,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.icon,
        ),
      ),
    );
  }
}
