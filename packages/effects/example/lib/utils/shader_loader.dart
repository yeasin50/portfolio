import 'dart:ui';
import 'package:flutter/material.dart';

typedef ShaderLoaderCallBack = FragmentShader Function(
  FragmentProgram shader,
  Rect bounds,
);

///  things I am trying to archive
/// - this will load the fragment shader
/// - will return  the shader to the parent for any  configuration
/// - and it will update based on the config I pass into config
///
///! The issue is it is not updating the ui and
///! I dont want to move FutureBuilder top of the parent
///! or remove StateFullyWidget that will gonna recall the api
/// At this point I can pass the animation Instance and use animation builder
/// but what will be a good way to handle this case
///
class ShaderLoader extends StatefulWidget {
  const ShaderLoader({
    super.key,
    required this.path,
    required this.onLoaded,
    this.child = const SizedBox.expand(),
    this.blendMode = BlendMode.srcIn,
  });

  final String path;
  final ShaderLoaderCallBack onLoaded;
  final BlendMode blendMode;

  /// default it will be using SizedBox.Expand
  final Widget child;

  @override
  State<ShaderLoader> createState() => _ShaderLoaderState();
}

class _ShaderLoaderState extends State<ShaderLoader> {
  Future<FragmentProgram> loadMyShader() async =>
      await FragmentProgram.fromAsset(widget.path);

  late final Future<FragmentProgram> _program = loadMyShader();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _program,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.child;
        }

        if (!snapshot.hasData) {
          return const Text("Loading shader...");
        }

        return ShaderMask(
          shaderCallback: (bounds) {
            final modifiedShader = widget.onLoaded(snapshot.data!, bounds);
            return modifiedShader;
          },
          blendMode: widget.blendMode,
          child: widget.child,
        );
      },
    );
  }
}
