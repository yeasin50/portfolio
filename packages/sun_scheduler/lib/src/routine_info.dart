import 'models/entity_row.dart';

class RoutineInfo {
  RoutineInfo({
    required this.title,
    required this.headers,
    required this.entities,
  });

  final String title;
  final List<String> headers;
  final List<EntityRow> entities;

  factory RoutineInfo.fromMap(Map<String, dynamic> map) {
    try {
      final data = map["entities"] as Map<String, dynamic>;

      final List<EntityRow> entities = [];
      for (final e in data.entries) {
        final value = e.value;
        if (e.value is List) {
          for (final r in value) {
            entities.add(TimeSlotRow.fromMap(r));
          }
        } else if (value is int) {
          entities.add(HolidayRow.fromMap(e));
        } else {
          throw "invalid value type ${value.runtimeType}";
        }
      }

      return RoutineInfo(
        title: map["title"],
        headers: List.from(map["headers"]),
        entities: entities,
      );
    } catch (e) {
      throw "failed to parse RoutineInfo ${e.toString()}";
    }
  }
}
