import 'dart:ui';

import 'package:flutter/material.dart';

///todo sineWave
class ShaderLoader extends StatefulWidget {
  const ShaderLoader({
    super.key,
    required this.path,
    this.child,
  });

  final String path;
  final Widget? child;

  @override
  State<ShaderLoader> createState() => _ShaderLoaderState();
}

class _ShaderLoaderState extends State<ShaderLoader>
    with SingleTickerProviderStateMixin {
  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset(widget.path);

  late final Future<FragmentProgram> _program = loadMyShader();

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(minutes: 1),
    upperBound: 100,
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    Offset focalPoint = Offset(size.width / 2, size.height / 2);
    return FutureBuilder(
      future: _program,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error loading shader: ${snapshot.error}");
        }
        if (snapshot.hasData == false) {
          return const Text("loading shader...");
        }

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                final shader = snapshot.data!.fragmentShader()
                  ..setFloat(0, size.width)
                  ..setFloat(1, size.height)
                  ..setFloat(2, focalPoint.dx)
                  ..setFloat(3, focalPoint.dy)
                  ..setFloat(4, controller.value);
                return shader;
              },
              blendMode: BlendMode.color,
              child: child!,
            );
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            padding: EdgeInsets.all(8),
            // itemCount: 30,
            itemBuilder: (context, index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length],
              );
            },
          ),
        );
      },
    );
  }
}
