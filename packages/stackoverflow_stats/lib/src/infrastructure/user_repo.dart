import 'dart:convert';
import 'dart:developer';

import 'package:stackoverflow_stats/src/domain/badge.dart';
import 'package:stackoverflow_stats/src/domain/so_profile.dart';
import 'package:stackoverflow_stats/src/domain/user_repo.dart';

import 'package:http/http.dart' as http;

///  fetch  StackOverflow user's profile  stats
///
class SOUserRepo implements IUserRepo {
  final Uri _baseUri = Uri.parse("https://api.stackexchange.com");

  @override
  Future<List<SOBadge>> getBadges(int userId) async {
    final uri = _baseUri.replace(
      path: "2.3/users/$userId/badges",
      queryParameters: {
        "order": "asc",
        "sort": "rank",
        "site": "stackoverflow",
        "filter": "!*Ju1)4puHkF7IgTp"
      },
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["items"] as List;
        return data.map((e) => SOBadge.fromMap(e)).toList();
      }

      log("failed to fetch user $userId ${response.body}");
    } catch (e, st) {
      log("${e.toString()}  ${st.toString()}");
    }
    return [];
  }

  @override
  Future<SoProfile?> getUserProfile(int userId) async {
    final uri = _baseUri.replace(
      path: "2.3/users/$userId",
      queryParameters: {
        "order": "desc",
        "sort": "reputation",
        "site": "stackoverflow",
        "filter": "!)d4SmoFcF*-ogAbQVWSoTzjj1Uk1KShei2G81TgYlpAOZ"
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return SoProfile.fromMap(jsonDecode(response.body));
      }

      log("failed to fetch user $userId ${response.body}");
    } catch (e, st) {
      log("${e.toString()}  ${st.toString()}");
    }
    return null;
  }
}
