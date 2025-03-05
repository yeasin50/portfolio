import 'dart:ui';

/// topic for each connect options gonna show on main connect page
/// Also includes  [principles] which are [ConnectionPrinciple] list group data gonna show in details page
///
class ConnectOption {
  const ConnectOption({
    required this.name,
    this.tldr,
    this.background,
    required this.principles,
  });

  final String name;
  final String? tldr;
  final Color? background;
  final List<ConnectionPrinciple> principles;

  factory ConnectOption.fromMap(Map<String, dynamic> map) {
    return ConnectOption(
      name: map["name"],
      background: map["background"],
      principles: map["principles"]?.map(
            (e) => ConnectionPrinciple.fromMap(e),
          ) ??
          [],
    );
  }
}

class ConnectionPrinciple {
  const ConnectionPrinciple({
    required this.title,
    required this.category,
    this.items = const [],
  });

  final String category;
  final String title;
  final List<PrincipleInfo> items;

  factory ConnectionPrinciple.fromMap(Map<String, dynamic> map) {
    return ConnectionPrinciple(
      category: map["category"],
      title: map["title"],
      items: map["items"] == null
          ? []
          : List.from(map["items"].map((e) => PrincipleInfo.fromMap(e))),
    );
  }

  @override
  String toString() =>
      'ConnectionPrinciple(category: $category, title: $title, items: $items)';
}

class PrincipleInfo {
  const PrincipleInfo({
    required this.name,
    required this.data,
  });

  final String name;
  final List<String> data;

  factory PrincipleInfo.fromMap(Map<String, dynamic> map) {
    return PrincipleInfo(
      name: map["name"],
      data: List.from(map["data"]),
    );
  }

  @override
  String toString() => 'PrincipleInfo(name: $name, data: $data)';
}
