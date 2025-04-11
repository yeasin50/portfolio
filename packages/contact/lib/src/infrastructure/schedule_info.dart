import 'package:flutter/material.dart';

enum ScheduleState {
  busy,
  available,
  hide,
  ;

  static ScheduleState fromMap(String? str) {
    return switch (str) {
      "busy" => ScheduleState.busy,
      "available" => ScheduleState.available,
      _ => ScheduleState.hide,
    };
  }
}

///  for the domain level use
///
/// - [availableFrom] -> `available_from` to provide date e.g "2025-04-07T12:00:00Z"
///
/// - [timeSlots] is map of dayNumber and available slots. can be empty
///
class Schedules {
  const Schedules({
    required this.availableFrom,
    required this.timeSlots,
    required this.state,
    this.message,
    this.appointmentURL,
    this.show = true,
  });

  final DateTime? availableFrom;

  final ScheduleState state;

  final String? message;

  /// navigate to the original site
  final String? appointmentURL;

  /// key represents the day of the week (0 = Sunday, 6 = Saturday),
  /// and the value is a list of available time slots.
  final Map<int, List<TimeOfDay>> timeSlots;

  final bool show;

  /// parse from  map
  /// ```json
  ///   {
  ///   "available_from": "2024-03-07T10:00:00Z",
  ///   "time_slots": {
  ///     "1": ["08:30", "12:00", "15:45"],
  ///     "5": ["07:00", "13:00", "18:00"]
  ///   },
  /// }
  /// ```
  static Schedules fromMap(Map<String, dynamic> map) {
    return Schedules(
      availableFrom: DateTime.tryParse(map["available_from"] ?? ""),
      state: ScheduleState.fromMap(map["state"]),
      appointmentURL: map["appointment_url"],
      message: map["message"],
      show: map["show"] ?? true,
      timeSlots: (map["time_slots"] as Map?)?.map<int, List<TimeOfDay>>(
            (key, value) => MapEntry(
                int.parse(key),
                (value as List?)?.map<TimeOfDay>(
                      (time) {
                        final parts = (time as String).split(":");
                        return TimeOfDay(
                          hour: int.parse(parts[0]),
                          minute: int.parse(parts[1]),
                        );
                      },
                    ).toList() ??
                    []),
          ) ??
          {},
    );
  }

  @override
  String toString() {
    return 'Schedules(availableFrom: $availableFrom, state: $state, message: $message, appointmentURL: $appointmentURL, timeSlots: $timeSlots, show: $show)';
  }
}
