import 'time_slot.dart';

/// A Row can have either
/// - `duration` in days
/// - `startDate` and `endDate` can be convert from  duration
/// - `slot` will be List<TimeOfDay>
abstract class EntityRow {
  const EntityRow({required this.name});

  final String name;
}

class TimeSlotRow extends EntityRow {
  const TimeSlotRow({
    required super.name,
    this.slot = const [], //
  });

  final List<TimeSlot> slot;

  @override
  factory TimeSlotRow.fromMap(MapEntry e) {
    List<TimeSlot> slots = [];
    final value = e.value;
    if (value is List) {
      for (final r in value) {
        slots.add(TimeSlot.fromMap(r));
      }
    } else {
      throw "invalid value type ${value.runtimeType}";
    }

    return TimeSlotRow(name: e.key, slot: slots);
  }
}

class HolidayRow extends EntityRow {
  const HolidayRow({
    required super.name,
    required this.duration,
    this.startDate,
    this.endDate,
  });
  final Duration duration;
  final DateTime? startDate;
  final DateTime? endDate;

  factory HolidayRow.fromMap(MapEntry e) {
    assert(e.value is int);
    return HolidayRow(name: e.key, duration: Duration(days: e.value));
  }
}
