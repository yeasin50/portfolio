import 'dart:convert';

import 'package:contact/contact.dart';
import 'package:core/core.dart';

import 'package:http/http.dart' as http;

import 'models/general_response.dart';
import 'models/user_info_response.dart';

class ApiService {
  ApiService(String baseAPIUrl) {
    baseUri = Uri.parse(baseAPIUrl);
  }

  late final Uri baseUri;

  Future<T> _get<T>(
    String path, {
    T Function(Map<String, dynamic> body)? fromJson,
  }) async {
    final response = await http.get(baseUri.replace(path: path));

    if (response.statusCode != 200) {
      throw Exception(
          'API Exception: ${response.statusCode}: ${response.body}');
    }

    if (fromJson != null) {
      final Map<String, dynamic> body = json.decode(response.body);
      return fromJson(body);
    } else {
      throw Exception("fromJson function is required");
    }
  }

  Future<UserInfoResponse> getUserInfo() async {
    return _get(
      "/user_info",
      fromJson: UserInfoResponse.fromMap,
    );
  }

  Future<List<Project>> getProjects() async {
    final response = await _get<GeneralResponse<Project>>(
      "/projects",
      fromJson: (body) {
        return GeneralResponse<Project>.fromMap(
          body,
          (projectMap) => Project.fromMap(projectMap),
        );
      },
    );

    return response.data;
  }

  Future<List<ConnectOption>> getConnectOptions() async {
    final response = await _get<GeneralResponse<ConnectOption>>(
      "/connect_option",
      fromJson: (body) {
        return GeneralResponse<ConnectOption>.fromMap(
          body,
          (projectMap) => ConnectOption.fromMap(projectMap),
        );
      },
    );

    return response.data;
  }
}
