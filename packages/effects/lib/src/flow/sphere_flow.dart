import 'package:flutter/material.dart';

import 'sphere_delegate.dart';

class SphereFlow extends StatefulWidget {
  const SphereFlow({
    super.key,
    required this.children,
    required this.callback,
  });
  final List<Widget> children;
  final SphereCircularFlowCallback callback;

  @override
  State<SphereFlow> createState() => _SphereFlowState();
}

class _SphereFlowState extends State<SphereFlow>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..forward();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: SphereCircularFlowDelegate(
        animation: controller,
        callback: widget.callback,
      ),
      children: widget.children,
    );
  }
}
