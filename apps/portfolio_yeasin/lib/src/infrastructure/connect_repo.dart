import 'package:contact/contact.dart';

import 'dart:convert';

import 'utils/get_resource.dart';

class UserConnectRepo implements IConnectRepo {
  const UserConnectRepo._(this._options);
  final List<ConnectOption> _options;

  static Future<UserConnectRepo> create() async {
    try {
      var response =
          await GetResource.fetchResponse("resource/json/connect_option.json");

      final data = jsonDecode(response)["data"] as List?;

      final List<ConnectOption> items = List<ConnectOption>.from(
        data?.map((e) => ConnectOption.fromMap(e)) ?? [],
      );

      return UserConnectRepo._(items);
    } catch (e) {
      rethrow; // You can throw custom error messages as needed
    }
  }

  @override
  List<ConnectOption> get items => List.unmodifiable(_options);
}
