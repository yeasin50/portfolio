import 'package:flutter/material.dart';

import 'src/utils/shader_loader.dart';

class SineWaveEffect extends StatefulWidget {
  const SineWaveEffect({
    super.key,
    required this.child,
  });
  final Widget? child;

  @override
  State<SineWaveEffect> createState() => _SineWaveEffectState();
}

class _SineWaveEffectState extends State<SineWaveEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..repeat(reverse: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final focalPoint = Offset(size.width / 2, size.height / 2);
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ShaderLoader(
            path: "shaders/water_ripple.frag",
            blendMode: BlendMode.srcATop,
            onLoaded: (program, bounds) {
              var shader = program.fragmentShader();
              shader
                ..setFloat(0, size.width)
                ..setFloat(1, size.height)
                ..setFloat(2, focalPoint.dx)
                ..setFloat(3, focalPoint.dy)
                ..setFloat(4, controller.value);
              return shader;
            },
            child: child!,
          );
        },
        child: widget.child ?? SizedBox.expand()
        //  GridView.builder(
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 100,
        //     crossAxisSpacing: 4,
        //     mainAxisSpacing: 4,
        //   ),
        //   padding: EdgeInsets.all(8),
        //   itemBuilder: (context, index) {
        //     return ColoredBox(
        //       color: Colors.primaries[index % Colors.primaries.length],
        //     );
        //   },
        // ),
        );
  }
}
