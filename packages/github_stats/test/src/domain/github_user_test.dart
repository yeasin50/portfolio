import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_stats/src/domain/github_user.dart';

import '../../fixture/fixture.dart';

void main() {
  test("Parse user", () {
    final data = fixture("user_http_response.json");
    final usr = GithubUser.fromMap(jsonDecode(data));

    expect(usr, isA<GithubUser>());
  });
}
