import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stackoverflow_stats/src/domain/so_profile.dart';

void main() {
  test("so parser", () {
    SoProfile p = SoProfile.fromMap(jsonDecode(_profileJson));

    expect(p.accountId, 14061061);
    expect(p.bronzeBadgeCount, 81);
    expect(p.silverBadgeCount, 47);
    expect(p.goldBadgeCount, 7);
    expect(p.totalQuestion, 11);
    expect(p.totalAnswer, 3514);
    expect(p.reputation, 63414);
  });
}

const _profileJson = '''{
    "items": [
        {
            "badge_counts": {
                "bronze": 81,
                "silver": 47,
                "gold": 7
            },
            "view_count": 9304,
            "down_vote_count": 142,
            "up_vote_count": 1067,
            "answer_count": 3514,
            "question_count": 11,
            "account_id": 14061061,
            "reputation": 63414,
            "creation_date": 1532977660,
            "user_type": "registered",
            "user_id": 10157127,
            "location": "Dhaka, Bangladesh",
            "website_url": "http://linkedin.com/in/mdyeasinsheikh/",
            "link": "https://stackoverflow.com/users/10157127/md-yeasin-sheikh",
            "profile_image": "https://www.gravatar.com/avatar/2806c3e68c9430daad72eb502f0be8b4?s=256&d=identicon&r=PG&f=y&so-version=2",
            "display_name": "Md. Yeasin Sheikh"
        }
    ],
    "has_more": false,
    "quota_max": 300,
    "quota_remaining": 242
}
''';
