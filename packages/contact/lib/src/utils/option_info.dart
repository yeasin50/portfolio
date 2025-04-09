import 'package:flutter/material.dart';

class OptionInfo {
  final String label;
  final String? description;
  final List<Color>? sphereColor;

  OptionInfo({
    required this.label,
    this.description,
    this.sphereColor,
  });

  OptionInfo copyWith({
    String? label,
    String? description,
    List<Color>? sphereColor,
  }) {
    return OptionInfo(
      label: label ?? this.label,
      description: description ?? this.description,
      sphereColor: sphereColor ?? this.sphereColor,
    );
  }
}
