import 'dart:convert';

import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  group('project info ...', () {
    const jsonString = r'''{
      "id": "1",
      "title": "FamTree",
      "description": "Create Family tree, share with others, collaborate and chat with family members.",
      "category": "Mobile Application",
      "roll": "Flutter Developer",
      "created_at": "2023-11-01T00:00:00Z",
      "thumbnail": "",
      "media": [
        {
         "title": "something",
         "description": "tadata",
         "data": [
            {
              "type": "image",
              "value":"somelink"
           }
         ]
        }
        ], 
      "tasks": [
        "Developed the main UI",
        "Implemented real-time chat functionality",
        "Ensured seamless family tree collaboration"
      ]
    }''';

    test("parse from json", () {
      //
      final data = jsonDecode(jsonString);
      final result = Project.fromMap(data);

      expect(result, isA<Project>());
    });
  });
}
