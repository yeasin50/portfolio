import 'dart:convert';
import 'dart:developer';

import '../domain/badge.dart';
import '../domain/so_profile.dart';
import '../domain/user_repo.dart';

import 'package:http/http.dart' as http;

///  fetch  StackOverflow user's profile  stats
///
class SOUserRepo implements IUserRepo {
  final Uri _baseUri = Uri.parse("https://api.stackexchange.com");

  @override
  Future<List<SOBadge>> getBadges(
    int userId, {
    int page = 1,
    List<SOBadge>? result,
  }) async {
    result ??= [];
    // description skipped intentionally
    final uri = _baseUri.replace(
      path: "2.3/users/$userId/badges",
      queryParameters: {
        "pagesize": "100",
        "page": "$page",
        "order": "asc",
        "sort": "rank",
        "site": "stackoverflow",
        "filter": "!6J*U.Mc3P0xIC",
      },
    );
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body["items"] as List;
        final hasMore = body["has_more"] ?? false;
        final items = data.map((e) => SOBadge.fromMap(e)).toList();
        result.addAll(items);
        log(result.length.toString());
        if (hasMore) {
          ///😂 recursion is good, it will be nice to have stream

          return getBadges(userId, page: page + 1, result: result);
        }
      } else {
        log("failed to fetch user $userId ${response.body}");
      }
    } catch (e, st) {
      log("${e.toString()}  ${st.toString()}");
    }

    return result;
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
