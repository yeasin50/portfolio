import 'package:flutter/material.dart';
import 'package:sun_scheduler/sun_scheduler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF323956),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
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
            ),
          ),
        ),
      ),
    );
  }
}
