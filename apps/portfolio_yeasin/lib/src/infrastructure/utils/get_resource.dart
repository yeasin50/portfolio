import 'package:flutter/foundation.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;

mixin GetResource {
  static Future<String> fetchResponse(String resourcePath) async {
    var response;

    if (kDebugMode) {
      if (kIsWeb) {}

      final currentDir = io.Directory.current.path;
      final filePath = '$currentDir/../../$resourcePath';
      final file = io.File(filePath);

      if (!await file.exists()) {
        throw Exception("File not found: $filePath");
      }

      response = await file.readAsString();
      print("File read successfully: $filePath");
    } else {
      // Future: Fetch from network
      throw UnimplementedError('Network fetch is not implemented.');
    }

    return response;
  }
}
