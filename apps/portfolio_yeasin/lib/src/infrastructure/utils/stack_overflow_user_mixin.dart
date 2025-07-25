import 'package:core/core.dart';
import 'package:collection/collection.dart';

mixin StackOverflowMixin {
  ({int? id, Connect? profile}) getSOId(List<Connect> connects) {
    final so = connects.firstWhereOrNull((e) => e.name == "stackOverflow");
    if (so == null) return (id: null, profile: null);

    RegExp regExp = RegExp(r"users/(\d+)");
    Match? match = regExp.firstMatch(so.url);

    if (match != null) {
      return (id: int.tryParse(match.group(1)!), profile: so);
    } else {
      return (id: null, profile: null);
    }
  }
}
