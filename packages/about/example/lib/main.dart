import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive/responsive.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return MaterialApp(home: AboutPageSetup());
  }
}

class AboutPageSetup extends StatelessWidget {
  const AboutPageSetup({super.key});

  @override
  Widget build(BuildContext context) {
    
    final jsonPath = 'assets/json/about.json';

    _load() async {
      final data = await rootBundle.loadString(jsonPath);
      return data;
    }

    return FutureBuilder(
      future: _load(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = AboutPageData.fromJson(snapshot.data!);
          return AboutPage(data: data);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
