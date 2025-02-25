import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

///  track  the global level mouse
///  this doesn't handle updating widget,
///  use [onMouseMove] on parent to update the ui
///
/// ```dart
/// class _HomeState extends State<Home>
///     with eff.MouseTrackerMixin {
///   void onMouseMovement(Offset position) {
///     print(position);
///   }
///
///   @override
///   void initState() {
///     super.initState();
///     onMouseMove = onMouseMovement;
///   }
/// ```
///
mixin MouseTrackerMixin<T extends StatefulWidget> on State<T> {
  Offset mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    GestureBinding.instance.pointerRouter.addGlobalRoute(_onPointerMove);
  }

  void Function(Offset)? onMouseMove;

  void _onPointerMove(PointerEvent event) {
    if (mounted) {
      mousePosition = event.position;
      onMouseMove?.call(mousePosition);
    }
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter.removeGlobalRoute(_onPointerMove);
    super.dispose();
  }
}
