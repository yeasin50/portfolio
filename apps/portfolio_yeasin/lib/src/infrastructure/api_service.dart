import 'dart:convert';

import 'package:contact/contact.dart';
import 'package:core/core.dart';

import 'package:http/http.dart' as http;

import 'models/general_response.dart';
import 'models/user_info_response.dart';

///  Get data from  [baseUri] endPoint.
///* If it contains `githubusercontent` then it has been handled accordingly ;xD
///
class ApiService {
  ApiService(String baseAPIUrl) {
    baseUri = Uri.parse(baseAPIUrl);
  }

  late final Uri baseUri;

  Future<T> _get<T>(
    String path, {
    T Function(Map<String, dynamic> body)? fromJson,
  }) async {
    late Uri uri;
    if (baseUri.host.contains("githubusercontent")) {
      path = path.replaceFirst("/", ""); //already handled  in  baseUri
      uri = Uri.parse("${baseUri.toString()}$path.json");
    } else {
      uri = baseUri.replace(path: path);
    }

    final response = await http.get(uri);

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
