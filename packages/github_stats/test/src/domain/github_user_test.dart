import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_stats/src/domain/github_user.dart';

import '../../fixture/fixture.dart';

void main() {
  test("fetch user data", () {
    final data = fixture("github_user_response.json");
    final mapData = jsonDecode(data)["data"];

    final user = GithubUser.fromMap(mapData);

    ///
  });
}
