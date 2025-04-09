import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'github_user.dart';

part 'graph_query.dart';

class GitUserStats {
  GitUserStats._(this.userId);

  final String userId;

  ///
  static Future<GitUserStats?> init(String userId) async {
    return GitUserStats._(userId);
  }

  ///  get user Info or return error message
  Future<(GithubUser?, String?)> getUser() async {
    try {
      final url = Uri.parse("https://api.github.com/users/$userId");
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return (null, "failed to get the user");
      }

      final user = GithubUser.fromMap(jsonDecode(response.body));
      return (user, null);
    } catch (e, st) {
      debugPrint("${e.toString()} \n ${st.toString()}");
      return (null, "failed to get the user");
    }
  }
}
