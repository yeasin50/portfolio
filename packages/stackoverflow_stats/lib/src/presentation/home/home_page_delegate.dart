part of 'so_home_page.dart';

double _degToRad(double deg) => deg / (math.pi * 180);

class _SOFlowDelegate extends FlowDelegate {
  const _SOFlowDelegate({
    required this.animation,
    this.hoverIndex,
    required this.badges,
  }) : super(repaint: animation);

  final Animation animation;
  final int? hoverIndex;
  final List<SOBadge> badges;

  @override
  void paintChildren(FlowPaintingContext context) {
    print(badges.length);
//     final Offset center = Offset(
//       context.size.width / 2,
//       context.size.height / 2,
//     );
//
//     final mainBox = context.getChildSize(0)!;

    // context.paintChild(
    //   0,
    //   transform: Matrix4.identity()
    //     ..translate(
    //       center.dx - mainBox.width / 2,
    //       center.dy - mainBox.height / 2,
    //     ),
    // );

    for (int i = 1; i < badges.length; i++) {
      final radius = math.max(context.size.width, context.size.height) / 2;
      final angle = (i * 2 * math.pi) / 3;

      final itemSize = context.getChildSize(i)!;
      context.paintChild(i, transform: Matrix4.identity()
          // ..translate(
          //   i,
          // ),
          );
    }
  }

  @override
  bool shouldRepaint(covariant _SOFlowDelegate oldDelegate) {
    return badges.length != oldDelegate.badges.length;
  }
}
