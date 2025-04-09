import 'package:stackoverflow_stats/src/domain/so_profile.dart';

import 'badge.dart';

abstract interface class IUserRepo {
  Future<SoProfile?> getUserProfile(int userId);

  Future<List<SOBadge>> getBadges(int userId);
}
