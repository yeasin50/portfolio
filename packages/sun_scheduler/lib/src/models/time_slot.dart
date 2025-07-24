import 'package:flutter/material.dart';
import 'package:time_machine2/time_machine2.dart' as tz;

///  [RoutineInfo] is the data of RoutineView
/// parse daily time slots
///
// {
//     "start_work" : "05:00 am",
//     "end_work" : "08:00 am",
// },
class TimeSlot {
  TimeSlot({
    required this.start,
    required this.end, //
  });

  final TimeOfDay start;
  final TimeOfDay end;

  static TimeOfDay? parseTimeOfDay(String data) {
    try {
      int? hour = int.tryParse(data.split(":").first);
      final minuteAm = data.split(":").last.split(" ");
      final minute = int.tryParse(minuteAm.first);
      if (hour == null || minute == null) {
        return null;
      }
      if (minuteAm.last.toLowerCase() == "pm") {
        hour += 12;
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      throw "failed to parse TimeOFDay ${e.toString()}";
    }
  }

  // "start_work" : "05:00 am"
  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    try {
      final startSection = map.keys.firstWhere((e) => e.startsWith("start"));
      final endSection = map.keys.firstWhere((e) => e.startsWith("end"));

      return TimeSlot(
        start: parseTimeOfDay(map[startSection])!,
        end: parseTimeOfDay(map[endSection])!, //
      );
    } catch (e) {
      throw "invalid TimeSlot:  must start with `start` or `end`";
    }
  }
}

extension TimeSlotConverter on TimeSlot {
  TimeSlot toZone({
    required tz.DateTimeZone zone,
    required DateTime updatedAt,
  }) {
    final userUTC = updatedAt;
    final startIntance = tz.Instant.utc(
      userUTC.year,
      userUTC.month,
      userUTC.day,
      start!.hour,
      start!.minute,
    );

    final endIntance = tz.Instant.utc(
      userUTC.year,
      userUTC.month,
      userUTC.day,
      end!.hour,
      end!.minute,
    );

    final start = tz.ZonedDateTime(startIntance, zone);
    final end = tz.ZonedDateTime(endIntance, zone);
    return TimeSlot(
      start: TimeOfDay(hour: start.hourOfDay, minute: start.minuteOfHour),
      end: TimeOfDay(hour: end.hourOfDay, minute: end.minuteOfHour),
    );
  }
}
