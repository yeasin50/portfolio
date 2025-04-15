import 'package:effects/src/widgets/sphere_view.dart';
import 'package:flutter/material.dart';

/// circle button with homeIcon
///
/// if [scrollProgress] is not null, it will show scroll progress around icon
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.scrollProgress != null)
            Center(
              child: CircularProgressIndicator(
                value: widget.scrollProgress,
                color: Colors.white,
              ),
            ),
          SphereView(
            colors: [Colors.lightBlueAccent.shade100, Colors.transparent],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
