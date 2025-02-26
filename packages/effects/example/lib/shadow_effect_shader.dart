import 'package:flutter/material.dart';

import 'package:effects/effects.dart' as eff;
import 'src/utils/shader_loader.dart';

@Deprecated(
  "this doesn't work yet",
)
class ShadowEffectShader extends StatefulWidget {
  const ShadowEffectShader({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShadowEffectShader> createState() => _ShadowEffectShaderState();
}

class _ShadowEffectShaderState extends State<ShadowEffectShader>
    with eff.MouseTrackerMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ShaderLoader(
      path: "shaders/shadow.frag",
      blendMode: BlendMode.softLight,
      onLoaded: (program, bounds) {
        var shader = program.fragmentShader();

        //dart format off
        shader.setFloat(0, size.width);
        shader.setFloat(1, size.height);
        shader.setFloat(2, 200);
        shader.setFloat(3, 100);
        shader.setFloat(4, 100);

        shader.setFloat(5, Colors.white.r);
        shader.setFloat(6, Colors.white.g);
        shader.setFloat(7, Colors.white.b);

        //dart format on
        return shader;
      },
      child: widget.child,
    );
  }
}
