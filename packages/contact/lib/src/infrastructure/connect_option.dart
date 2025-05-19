import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'schedule_info.dart';

/// topic for each connect options gonna show on main connect page
/// Also includes  [principles] which are [ConnectionPrinciple] list group data gonna show in details page
///
class ConnectOption {
  const ConnectOption({
    required this.name,
    this.tldr,
    this.description = const [],
    this.background,
    required this.principles,
    this.schedules,
    this.show = true,
  });

  final String name;
  @Deprecated(
      "use [description] instead.This is deprecated and will be removed")
  final String? tldr;

  /// same as tldr but little long description can have link, dialogs etc
  final List<TextSpanData> description;

  final Color? background;
  final List<ConnectionPrinciple> principles;
  final Schedules? schedules;
  final bool show;

  bool get showSchedule {
    return schedules != null && schedules!.state != ScheduleState.hide;
  }

  factory ConnectOption.fromMap(Map<String, dynamic> map) {
    List<TextSpanData> spans = [];
    if (map["description"] != null) {
      spans = List.from(
        map["description"].map((e) => TextSpanData.fromMap(e)),
      );
    }

    return ConnectOption(
      name: map["type"],
      background: map["background"],
      tldr: map["tldr"],
      description: spans,
      schedules:
          map["schedules"] != null ? Schedules.fromMap(map["schedules"]) : null,
      principles: List.from(map["principles"]?.map(
            (e) => ConnectionPrinciple.fromMap(e),
          ) ??
          []),
      show: map["show"] ?? true,
    );
  }
}

class ConnectionPrinciple {
  const ConnectionPrinciple({
    required this.title,
    required this.category,
    this.items = const [],
    this.description = "",
    this.show = true,
  });

  /// A category that represents the overarching theme of the principle (e.g., "concern", "ok", "not-ok").
  final String category;
  final String title;
  final String description;

  final List<PrincipleInfo> items;
  final bool show;

  factory ConnectionPrinciple.fromMap(Map<String, dynamic> map) {
    return ConnectionPrinciple(
      category: map["category"],
      title: map["title"],
      description: map["description"] ?? "",
      items: map["items"] == null
          ? []
          : List.from(map["items"].map((e) => PrincipleInfo.fromMap(e))),
      show: map["show"] ?? true,
    );
  }

  @override
  String toString() {
    return 'ConnectionPrinciple(category: $category, title: $title, items: $items, show: $show)';
  }
}

class PrincipleInfo {
  const PrincipleInfo({
    required this.name,
    required this.data,
    this.description = "",
    this.category = "",
    this.show = true,
  });

  final String name;
  final List<String> data;
  final String description;

  /// A category that represents the overarching theme of the principle (e.g., "concern", "ok", "not-ok").
  final String category;

  final bool show;

  factory PrincipleInfo.fromMap(Map<String, dynamic> map) {
    return PrincipleInfo(
      name: map["name"],
      description: map["description"] ?? "",
      category: map["category"] ?? "",
      data: List.from(map["data"] ?? []),
      show: map["show"] ?? true,
    );
  }

  @override
  String toString() {
    return 'PrincipleInfo(name: $name, data: $data, description: $description, category: $category, show: $show)';
  }
}
