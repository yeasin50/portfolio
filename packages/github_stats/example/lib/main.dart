import 'package:flutter/material.dart';
import 'package:github_stats/github_stats.dart';

void main() async {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GithubUser? user;
  Future<void> fetch() async {
    final repo = await GitUserStats.init("yeasin50");
    final usr = await repo?.getUser();

    user = usr?.$1;
    setState(() {});
  }

  late final Future future = fetch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (user == null) return const Text("loading....");

          return Column(
            children: [
              GitUserOverviewCard(user: user!),
            ],
          );
        },
      ),
    );
  }
}
