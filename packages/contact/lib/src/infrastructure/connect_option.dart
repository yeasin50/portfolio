import 'package:flutter/material.dart';

import 'schedule_info.dart';

/// topic for each connect options gonna show on main connect page
/// Also includes  [principles] which are [ConnectionPrinciple] list group data gonna show in details page
///
class ConnectOption {
  const ConnectOption({
    required this.name,
    this.tldr,
    this.background,
    required this.principles,
    this.schedules,
  });

  final String name;
  final String? tldr;
  final Color? background;
  final List<ConnectionPrinciple> principles;
  final Schedules? schedules;

  bool get showSchedule {
    return schedules != null && schedules!.state != ScheduleState.hide;
  }

  factory ConnectOption.fromMap(Map<String, dynamic> map) {
    return ConnectOption(
      name: map["type"],
      background: map["background"],
      tldr: map["tldr"],
      schedules:
          map["schedules"] != null ? Schedules.fromMap(map["schedules"]) : null,
      principles: List.from(map["principles"]?.map(
            (e) => ConnectionPrinciple.fromMap(e),
          ) ??
          []),
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
    this.description = "",
    this.category = "",
  });

  final String name;
  final List<String> data;
  final String description;
  final String category;

  factory PrincipleInfo.fromMap(Map<String, dynamic> map) {
    return PrincipleInfo(
      name: map["name"],
      description: map["description"] ?? "",
      category: map["category"] ?? "",
      data: List.from(map["data"]??[]),
    );
  }

  @override
  String toString() {
    return 'PrincipleInfo(name: $name, data: $data, description: $description, category: $category)';
  }
}
