import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/infrastructure/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'connect_item_view.dart';

///  simple way of rendering times
///
/// ```dart
/// CompositedTransformFollower(
///   link: layerLink,
///   targetAnchor: Alignment.lerp(
///     Alignment.bottomCenter,
///     Alignment.bottomLeft,
///     t,
///   )!,
///   followerAnchor: Alignment.lerp(
///     Alignment.topCenter,
///     Alignment.topLeft,
///     t,
///   )!,
///   offset: const Offset(0, 24),
///   child: ConnectsSimpleView(animation: t),
/// ),
///```
class ConnectsSimpleView extends StatelessWidget {
  const ConnectsSimpleView({
    super.key,
    required this.animation,
  });
  final double animation;

  @override
  Widget build(BuildContext context) {
    late final List<Connect> data = context.provider.connects;

    void navToSite(String url) async {
      try {
        //why not canLaunch,
        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } catch (e) {
        //
      }
    }

    return Flow(
      delegate: _SimpleConnectFlowDelete(
        Animation.fromValueListenable(ValueNotifier(animation)),
      ),
      clipBehavior: Clip.none,
      children: data
          .map(
            (e) => ConnectButton(
              connect: e,
              onHovered: (v) {},
              onTap: () => navToSite(e.url),
            ),
          )
          .toList(),
    );
  }
}

class _SimpleConnectFlowDelete extends FlowDelegate {
  const _SimpleConnectFlowDelete(this.animation) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    List<Size> itemSize = [];

    for (int i = 0; i < context.childCount; i++) {
      itemSize.add(context.getChildSize(i)!);
    }
    final double spaceNeeded = itemSize.fold(0.0, (p, e) => p + e.width);

    double dx = lerpDouble(
        (context.size.width / 2) - spaceNeeded / 2, 0, animation.value)!;

    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(dx)
          ..scale(lerpDouble(1, .75, animation.value)!),
      );
      dx += itemSize[i].width + lerpDouble(16, 0, animation.value)!;
    }
  }

  @override
  bool shouldRepaint(covariant _SimpleConnectFlowDelete oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
