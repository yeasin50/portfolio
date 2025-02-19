import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_yeasin/src/presentation/_common/widgets/image_loader.dart';

import 'dart:math' as math;

import '../../../app/app.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        extensions: [
          WorkCardTheme.darkCardTheme(),
        ],
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              width: 400,
              child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ProjectCard3D(project: Project.ui)),
            ),
          ),
        ),
      ),
    ),
  );
}

@Deprecated(
  "Under construction, "
  " limitation of 2D canvas is bugging me"
  "Doesn't look cool to me, so yea gonna skip it"
  "we can add blur and others stuffs on hovered state,"
  "but still not what I wanted, I might shift to the glsl",
)
class ProjectCard3D extends StatefulWidget {
  const ProjectCard3D({
    super.key,
    required this.project,
  });

  final Project project;
  @override
  State<ProjectCard3D> createState() => _ProjectCard3DState();
}

class _ProjectCard3DState extends State<ProjectCard3D>
    with SingleTickerProviderStateMixin {
  late final project = widget.project;

  late final controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
    lowerBound: 0,
    upperBound: 1,
  )..addListener(() => setState(() {}));

  void onHover(_) {
    controller.forward(from: 0);
  }

  void onHoverExit(_) {
    controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double temp = 0;
  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<WorkCardTheme>()!;

    final descriptionCard = Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: cardTheme.titleStyle,
          ),
          Text(
            project.category * 44,
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: cardTheme.descriptionStyle,
          ),
        ],
      ),
    );

    //

    final imageBox = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cardTheme.bgColor,
        boxShadow: [
          BoxShadow(
            color: cardTheme.hoverColor,
            offset: const Offset(0, 0),
            blurRadius: lerpDouble(0, 16, controller.value)!,
            spreadRadius: lerpDouble(0, 16, controller.value)!,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: ImageLoader(
        media: project.thumbnail,
      ),
    );

    return InkWell(
      onTap: () {},
      hoverColor: Colors.transparent,
      child: Column(
        children: [
          Slider(
            value: 0,
            onChanged: (value) {
              controller.value = value;
              setState(() {});
            },
          ),
          Expanded(
            child: MouseRegion(
              onEnter: onHover,
              onExit: onHoverExit,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .001)
                        ..rotateY(math.pi * controller.value),
                      child: child!,
                    );
                  },
                  child: Flow(
                    clipBehavior: Clip.none,
                    delegate: ProjectCard3dFLowDelegate(controller),
                    children: [
                      //image
                      SizedBox.expand(child: imageBox),

                      SizedBox.expand(child: descriptionCard),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// why we need it,
/// like to control the render stack
/// if animation>.5 we gonna switch BG and TOP
/// * Children [TOP,BG]
class ProjectCard3dFLowDelegate extends FlowDelegate {
  const ProjectCard3dFLowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    assert(context.childCount == 2, "only 2 children is able to render now");

    final fbSize = context.getChildSize(0)!;

    final double rotation = math.pi;

    final t = 0;

    final bgTransform = Matrix4.identity()
      ..setEntry(3, 2, .001)
      // ..rotateX(rotation * t)
      ..rotateY(rotation * t)
      ..translate(0.0, 0.0, 00);

    final fgTransform = Matrix4.identity()
      ..setEntry(3, 2, .001)
      // ..rotateX(rotation * t)
      ..rotateY(rotation * t)
      ..translate(0.0, 0.0, 00.0);

    // final midTransform = Matrix4.identity()
    //   ..translate(fbSize.width / 2, 0.0, 120.0)
    //   // ..rotateY(( rotation * t))
    //   ..rotateY(90 * math.pi / 180 + (math.pi / 2 * animation.value));

    if (animation.value < .5) {
      context.paintChild(
        1,
        transform: bgTransform,
      );

      context.paintChild(
        0,
        transform: fgTransform,
      );
    } else {
      context.paintChild(
        0,
        transform: fgTransform,
      );
      //can add a different layer

      context.paintChild(
        1,
        transform: bgTransform,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
