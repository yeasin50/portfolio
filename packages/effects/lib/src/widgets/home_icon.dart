import 'package:effects/src/widgets/sphere_view.dart';
import 'package:flutter/material.dart';

/// circle button with homeIcon
///
/// if [scrollProgress] is not null, It check for [PrimaryScrollController] to show scroll offset.
/// it will show scroll progress around icon
///
class HomeIcon extends StatefulWidget {
  const HomeIcon({
    super.key,
    this.onTap,
    this.scrollProgress,
  });

  final VoidCallback? onTap;

  final double? scrollProgress;

  @override
  State<HomeIcon> createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  //

  double? scrollProgress;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    if (widget.scrollProgress != null) {
      scrollProgress = widget.scrollProgress;
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController = PrimaryScrollController.maybeOf(context);
      _scrollController?.addListener(listener);
    });
  }

  void listener() {
    scrollProgress =
        _scrollController!.offset / _scrollController!.position.maxScrollExtent;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController?.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: widget.onTap,
      child: SphereView(
        colors: [Colors.lightBlueAccent.shade100, Colors.transparent],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              if (scrollProgress != null)
                SizedBox.square(
                  child: CircularProgressIndicator(
                    value: scrollProgress,
                    color: Colors.white,
                  ),
                ),
              Icon(
                Icons.home,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
