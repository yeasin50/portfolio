import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

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

@Deprecated("Under construction, limitation of 2D canvas is bugging me")
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          project.thumbnail,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Placeholder(),
        ),
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 4,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..rotateY(math.pi * controller.value),
                        child: child!,
                      );
                    },
                    child: Flow(
                      clipBehavior: Clip.none,
                      delegate: ProjectCard3dFLowDelegate(controller),
                      children: const [
                        //image
                        SizedBox.expand(
                          child: ColoredBox(
                            color: Colors.blue,
                            child: Text(
                              "AF",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 44, color: Colors.white),
                            ),
                          ),
                        ),
                        // middle

                        ColoredBox(
                          color: Colors.purple,
                          child: Text(
                            "Mid",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 44, color: Colors.white),
                          ),
                        ),

                        SizedBox.expand(
                          child: ColoredBox(
                            color: Colors.red,
                            child: Text(
                              "BG",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 44, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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
/// * Children [TOP,MID,BG]
class ProjectCard3dFLowDelegate extends FlowDelegate {
  const ProjectCard3dFLowDelegate(this.animation) : super(repaint: animation);

  final Animation animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    assert(context.childCount == 3, "only 3 children is able to render now");

    final fbSize = context.getChildSize(0)!;

    final midGap = 100.0; //mid one

    final double rotation = math.pi;

    final t = 0;

    final bgTransform = Matrix4.identity()
      // ..rotateX(rotation * t)
      ..rotateY(rotation * t)
      ..translate(0.0, 0.0, 100.0);

    final fgTransform = Matrix4.identity()
      // ..rotateX(rotation * t)
      ..rotateY(rotation * t)
      ..translate(0.0, 0.0, -100.0);

    final midTransform = Matrix4.identity()
      ..rotateZ(math.pi)
      ..rotateY(math.pi / 2 + rotation * t)
      ..translate(0.0, 0.0, fbSize.width);

    if (animation.value < .5) {
      context.paintChild(
        2,
        transform: bgTransform,
      );
      context.paintChild(
        1,
        transform: midTransform,
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

      context.paintChild(
        1,
        transform: midTransform,
      );
      context.paintChild(
        2,
        transform: bgTransform,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
