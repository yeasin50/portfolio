import 'package:core/core.dart';
import 'package:collection/collection.dart';

mixin StackOverflowMixin {
  int? getSOId(List<Connect> connects) {
    final so = connects.firstWhereOrNull((e) => e.name == "stackOverflow");
    if (so == null) return null;

    RegExp regExp = RegExp(r"users/(\d+)");
    Match? match = regExp.firstMatch(so.url);

    if (match != null) {
      return int.tryParse(match.group(1)!);
    } else {
      return null;
    }
  }
}
