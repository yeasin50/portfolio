import 'package:contact/contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        extensions: [
          ContactThemeExt.darkTheme(),
        ],
      ),
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  final ValueNotifier<Alignment> offset = ValueNotifier(Alignment.center);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          offset.value = optionAlign(
            canvasSize: size,
            globeSize: Size.fromRadius(200),
            globeOffset: Offset(
              (size.width / 2) - 100,
              (size.height / 2) - 100,
            ),
            cursorPosition: event.position,
          );
          // offset.value = event.position;
        },
        child: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: OptionView(
              label: "label",
              lightAlign: offset,
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
