///-
///-
class Skill {
  const Skill({
    this.type,
    required this.name,
    this.description,
      this.level,
    this.started,
    this.stopped,
    this.moveTo,
    this.subItems = const [],
  });

  /// group name
  /// this will be the title like "Programming Languages", "Frameworks", etc.
  final String? type;

  final String name;
  final String? level;
  final String? description;

  ///  specified date you've played with the [name]
  /// and stopped using/remove focus from new [Skill]
  /// can create chain later
  final DateTime? started;
  final DateTime? stopped;

  final Skill? moveTo;
  final List<Skill> subItems;

  @override
  String toString() {
    return 'Skill(type: $type, name: $name, level: $level, description: $description, started: $started, stopped: $stopped, moveTo: $moveTo)';
  }
}
