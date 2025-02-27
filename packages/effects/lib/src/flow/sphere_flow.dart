import 'package:flutter/material.dart';

import 'sphere_delegate.dart';
import 'sphere_scroll_flow.dart';

class SphereFlow extends StatefulWidget {
  const SphereFlow({
    super.key,
    required this.children,
  });
  final List<Widget> children;

  @override
  State<SphereFlow> createState() => _SphereFlowState();
}

class _SphereFlowState extends State<SphereFlow>
    with SingleTickerProviderStateMixin {
  ///
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  )..forward();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: SphereScrollFlowDelegate(
        animation: controller,
      ),
      children: widget.children,
    );
  }
}
