import 'package:flutter/material.dart';
import 'package:sun_scheduler/sun_scheduler.dart';
import 'package:time_machine2/time_machine2.dart' as tm;
import 'package:flutter_timezone/flutter_timezone.dart' as tz;

void main() {
    WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<String> availableTimezone = [];
  String? myTimezone;
  List<String> filterTimezone = [];

  final seachController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tm.TimeMachine.initialize().then((_) {
      fetchLocalDB();
    });

    seachController.addListener(searchlistner);
  }

  void fetchLocalDB() async {
    availableTimezone = await tz.FlutterTimezone.getAvailableTimezones();
    filterTimezone = [...availableTimezone];
    myTimezone = await tz.FlutterTimezone.getLocalTimezone();

    setState(() {});
  }

  void searchlistner() {
    final text = seachController.text.trim();

    if (text.isEmpty) {
      filterTimezone = availableTimezone;
    } else {
      filterTimezone =
          availableTimezone
              .where((e) => e.toLowerCase().contains(text.toLowerCase()))
              .toList();
    }

    setState(() {});
  }

  @override
  void dispose() {
    seachController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323956),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              children: [
                Text("Your timezone :$myTimezone"),
                if (availableTimezone.isEmpty)
                  Text("loading....")
                else
                  Expanded(
                    child: Column(
                      children: [
                        SearchBar(controller: seachController),
                        Expanded(
                          child: ListView.separated(
                            itemCount: filterTimezone.length,
                            separatorBuilder: (_, _) => SizedBox(height: 8),
                            itemBuilder: (contex, i) {
                              return ListTile(
                                title: Text(
                                  filterTimezone[i],
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget exampleUI() {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: TimeZoneChip()),
        Align(
          alignment: Alignment.centerLeft,
          child: RoutineView(
            title: "Daily Schedule",
            headers: ["Day", "work-hour", "meeting"], //
            entity: [
              //row
              ["Saturday", "05:00-9:00", ""],
              ["Saturday", "05:00-9:00", "12:22-01:00"],
              ["Saturday", "05:00-9:00", ""],
              ["Saturday", "05:00-9:00", ""],
            ],
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: RoutineView(
            title: "Holidays",
            headers: ["Event", "period"], //
            entity: [
              //row
              ["Ramadan", "12April,2025 - 12May,2025"],
              ["Ramadan", "12April,2025 - 12May,2025"],
              ["Eid-Ul-Fitor", "05:00-9:00"],
            ],
          ),
        ),
      ],
    );
  }
}
