import 'package:flutter/material.dart';

import 'utils/shader_loader.dart';

class SineWaveEffect extends StatefulWidget {
  const SineWaveEffect({super.key});

  @override
  State<SineWaveEffect> createState() => _SineWaveEffectState();
}

class _SineWaveEffectState extends State<SineWaveEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.medium1,
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return child!;
          },
          child: ShaderLoader( 
            path: "shaders/sine_wave.frag",
            child: Text("AA BB" * 233),
          ),
        ),
      ),
    );
  }
}
