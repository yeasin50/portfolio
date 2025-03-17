import 'package:flutter/material.dart';

class GoldenSpiral extends StatefulWidget {
  const GoldenSpiral({super.key});

  @override
  State<GoldenSpiral> createState() => _GoldenSpiralState();
}

class _GoldenSpiralState extends State<GoldenSpiral> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

class GoldenSpiralFlowDelegate extends FlowDelegate {
  const GoldenSpiralFlowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {}

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
