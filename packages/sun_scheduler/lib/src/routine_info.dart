import 'dart:convert';

import 'package:flutter/material.dart';

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
  }

  // "start_work" : "05:00 am"
  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    final startSection = map.keys.firstWhere((e) => e.startsWith("start"));
    final endSection = map.keys.firstWhere((e) => e.startsWith("end"));

    return TimeSlot(
      start: parseTimeOfDay(map[startSection])!,
      end: parseTimeOfDay(map[endSection])!, //
    );
  }
}

class EntityRow {
  const EntityRow({required this.name, this.slot = const [], required this.duration});
  final String name;
  final List<TimeSlot> slot;
  final Duration? duration;

  ///
  factory EntityRow.fromMap(MapEntry e) {
    List<TimeSlot> slots = [];
    Duration? duration;
    final value = e.value;
    if (value is List) {
      for (final r in value) {
        slots.add(TimeSlot.fromMap(r));
      }
    } else if (value is int) {
      duration = Duration(days: e.value);
    }
    return EntityRow(name: e.key, slot: slots, duration: duration);
  }
}

class RoutineInfo {
  RoutineInfo({required this.title, required this.headers, required this.timezone, required this.entities});

  final String title;
  final List<String> headers;
  final String timezone;
  final List<EntityRow> entities;

  factory RoutineInfo.fromMap(Map<String, dynamic> map) {
    final data = map["entities"] as Map<String, dynamic>;

    final result = data.entries.map((e) => EntityRow.fromMap(e)).toList();

    return RoutineInfo(
      title: map["title"],
      headers: List.from(map["headers"]),
      timezone: map['timezone'],
      entities: result,
    );
  }
}
