import 'package:flutter/material.dart';

import 'widgets/intro_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String name = "Md. Yeasin Sheikh";
  final String intro = "Software Engineer | Flutter specialist";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: IntroPersistenceHeaderDelegate(
              name: name,
              intro: intro,
              maxHeight: 250,
              minHeight: 50,
            ),
          )
        ],
      ),
    );
  }
}
