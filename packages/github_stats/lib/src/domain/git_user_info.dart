import 'package:github_stats/src/domain/github_user.dart';

part 'graph_query.dart';

abstract interface class IGitUserStats {
  ///  get user Info or return error message
  /// user token  will get from environment
  Future<(GithubUser, String)> getUser(GithubGraphQuery query);
}
