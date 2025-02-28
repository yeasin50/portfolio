import 'package:flutter/material.dart';

class HrConnectPage extends StatefulWidget {
  static String route = "connect/hr";
  const HrConnectPage({super.key});

  @override
  State<HrConnectPage> createState() => _HrConnectPageState();
}

class _HrConnectPageState extends State<HrConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: Text("HR"),
      ),
    );
  }
}
