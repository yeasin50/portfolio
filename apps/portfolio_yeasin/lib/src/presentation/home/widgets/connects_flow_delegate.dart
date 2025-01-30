import 'package:flutter/material.dart';

//TODO: need to think about animation  flow
///
class ConnectFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0; // Start from the left
    final double dy = (context.size.height - context.getChildSize(0)!.height) /
        2; // Center vertically

    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(dx, dy, 0));
      dx += context.getChildSize(i)!.width + 10; // Add spacing between children
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}

class ConnectMultiChildDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    const padding = 24.0;
    List<Size> itemSize = [];

    for (int i = 0; i < 4; i++) {
      final item = layoutChild(i, BoxConstraints.loose(size));
      itemSize.add(item);
    }

    double dx = 0; //size.width / 2;
    double dy = 0;

    // dx -= itemSize.fold(0.0, (p, e) => p + (e.width));

    for (int i = 0; i < itemSize.length; i++) {
      positionChild(i, Offset(dx, dy));
      dx += itemSize[i].width + padding;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
