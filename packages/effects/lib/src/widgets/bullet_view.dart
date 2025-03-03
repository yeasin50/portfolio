part of 'bullet_item_view.dart';

enum BulletType {
  //circle to x
  cross(Colors.redAccent),
  //  circle to check
  ok(Colors.greenAccent),

  concern(Colors.amberAccent),
  ;

  const BulletType(this.color);

  final Color color;
}

class BulletView extends StatelessWidget {
  const BulletView({
    super.key,
    required this.type,
    this.bulletColor,
    required this.t,
    this.size = const Size.fromRadius(12),
  });

  ///  the null, it will use default color from [BulletType]
  final Color? bulletColor;
  final BulletType type;

  ///  controller value
  final double t;

  /// size of the shape on full expand.
  /// default is 24
  final Size size;

  @override
  Widget build(BuildContext context) {
    final color = bulletColor ?? type.color;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: ShapeBorder.lerp(
            const CircleBorder(),
            //FIXME: rotation
            switch (type) {
              BulletType.cross =>
                const StarBorder(points: 4, rotation: math.pi * 10),
              BulletType.ok => _CheckShapeBorder(),
              BulletType.concern => StarBorder(points: 4, valleyRounding: .8),
            },
            t,
          ),
          color: Colors.transparent,
          child: SizedBox.fromSize(
            size: Size.lerp(size / 2, size, t),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                    colors: [color, color.withAlpha(100)],
                    stops: [0, lerpDouble(.4, 1, t)!]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckShapeBorder extends OutlinedBorder {
  const _CheckShapeBorder({this.t = 1});
  final double t;
  @override
  OutlinedBorder copyWith({BorderSide? side}) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();

    final width = rect.width / 8;

    final startPoint = rect.centerLeft;

    final points = [
      startPoint,
      startPoint + Offset(width, 0),
      startPoint + Offset(width, width * 2),
      startPoint + Offset(width * 6, width * 2),
      startPoint + Offset(width * 6, width * 3),
      startPoint + Offset(0, width * 3),
    ];
    path
      ..moveTo(rect.center.dx, rect.center.dy)
      ..addPolygon(points, true);
    final tr = Matrix4.identity()
      ..translate(-width * 2, width * 1.25)
      ..rotateZ(-math.pi / 4);

    return path.transform(tr.storage);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
