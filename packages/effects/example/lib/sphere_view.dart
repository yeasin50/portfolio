import 'package:flutter/material.dart';

import 'utils/shader_loader.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SphereView(),
    ),
  );
}

class SphereView extends StatefulWidget {
  const SphereView({
    super.key,
  });

  @override
  State<SphereView> createState() => _SphereViewState();
}

class _SphereViewState extends State<SphereView>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 100),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final focalPoint = Offset(size.width / 2, size.height / 2);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return ShaderLoader(
                  path: "shaders/sphere_shader.frag",
                  blendMode: BlendMode.colorBurn,
                  onLoaded: (program, bounds) {
                    var shader = program.fragmentShader();
                    final light = Colors.white;
                    final surfaceColor = Colors.purpleAccent;
                    shader
                      ..setFloat(0, size.width)
                      ..setFloat(1, size.height)
                      ..setFloat(2, focalPoint.dx)
                      ..setFloat(3, focalPoint.dy)
                      //
                      ..setFloat(4, light.r)
                      ..setFloat(5, light.g)
                      ..setFloat(6, light.b)
                      //
                      ..setFloat(7, surfaceColor.r)
                      ..setFloat(8, surfaceColor.g)
                      ..setFloat(9, surfaceColor.b);
                    return shader;
                  },
                  child: Stack(
                    children: [
                      child!,
                      Text("A"),
                    ],
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red.withAlpha(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
