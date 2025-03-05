import 'package:contact/contact.dart';

import 'dart:convert';
import 'dart:io' if (dart.library.html) 'dummy.dart' as io;

import 'package:flutter/foundation.dart';

class UserConnectRepo implements IConnectRepo {
  const UserConnectRepo._(this._options);
  final List<ConnectOption> _options;

  static Future<UserConnectRepo> create() async {
    try {
      var response;
      if (kDebugMode) {
        final currentDir = io.Directory.current.path;
        final filePath =
            '$currentDir\\..\\..\\resource\\json\\connect_option.json';
        print("exits here ${await io.File(filePath).exists()}");
        response = await io.File(filePath).readAsString();
      } else {
        throw UnimplementedError('Network fetch is not implemented.');
      }

      final data = jsonDecode(response)["data"] as List?;

      final List<ConnectOption> items = List<ConnectOption>.from(
          data?.map((e) => ConnectOption.fromMap(e)) ?? []);

      return UserConnectRepo._(items);
    } catch (e) {
      rethrow; // You can throw custom error messages as needed
    }
  }

  @override
  List<ConnectOption> get items => List.unmodifiable(_options);
}
