import 'package:flutter/material.dart';

class ConnectItemView extends StatefulWidget {
  const ConnectItemView({super.key});

  @override
  State<ConnectItemView> createState() => _ConnectItemViewState();
}

class _ConnectItemViewState extends State<ConnectItemView>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Durations.long1,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        value //
            ? controller.forward()
            : controller.reverse();
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.lerp(
                  Alignment.bottomCenter,
                  Alignment.center,
                  controller.value,
                )!,
                child: ScaleTransition(
                  scale: controller,
                  child: FadeTransition(
                    opacity: controller,
                    child: _ConnectCard(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: child,
              ),
            ],
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.abc),
        ),
      ),
    );
  }
}

class _ConnectCard extends StatelessWidget {
  const _ConnectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Some text",
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            "Some text",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
