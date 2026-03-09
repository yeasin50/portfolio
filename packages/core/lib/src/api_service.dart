import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

part 'api_config.dart';

/// Signature for providing a token, could fetch from secure storage.
typedef TokenProvider = Future<String> Function();

/// refresh  the session with  and return an instance
/// which  can be saved from  auth repo impl
typedef RefreshTokenHandler<T> = Future<T> Function();

class ApiService {
  ///
  ApiService({
    required this.config,
    required this.tokenProvider,
    required this.refreshTokenHandler,
  }) : baseUri = Uri.parse(config.baseUrl);

  Logger get logger => config.logger;

  final ApiConfig config;

  final TokenProvider tokenProvider;
  final RefreshTokenHandler refreshTokenHandler;

  final Uri baseUri;

  /// if [fullPath] is not null, [path] will skip
  Future<T> _request<T>(
    String path, {
    String? fullPath,
    required String method,
    dynamic body,
    Map<String, dynamic /*String?|Iterable<String>*/>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
    bool retrying = false,
  }) async {
    try {
      String token = await tokenProvider();

      if (body != null && body is! Map && body is! List) {
        body = body.toJson();
      }

      final uri = fullPath != null
          ? Uri.parse(fullPath)
          : baseUri.replace(path: path, queryParameters: queryParameters);
      final request = http.Request(method, uri)
        ..headers.addAll({
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
          if (token.isNotEmpty)
            HttpHeaders.authorizationHeader: 'Bearer $token',
        });
      if (body != null) {
        request.body = jsonEncode(body);
        config.logger.d("post body:  $body");
      }

      final streamed = await request.send();
      final raw = await streamed.stream.bytesToString();

      final jsonMap = jsonDecode(raw) as Map<String, dynamic>;

      // Handle 401 Unauthorized
      // if (streamed.statusCode == 401 && !retrying) {
      //   // Save new tokens
      //   await refreshTokenHandler();
      //
      //   // Retry original request once
      //   return _request(
      //     path,
      //     method: method,
      //     body: body,
      //     queryParameters: queryParameters,
      //     fromJson: fromJson,
      //     retrying: true,
      //   );
      // }

      return fromJson(jsonMap);
    } on SocketException {
      return fromJson({
        "success": false,
        "message": "No internet connection",
        "data": null,
        "error": {"code": "NO_INTERNET"},
      });
    } on TimeoutException {
      return fromJson({
        "success": false,
        "message": "Request timed out",
        "data": null,
        "error": {"code": "TIMEOUT"},
      });
    } catch (e, st) {
      config.logger.e("Error ${e.toString()} \n ${st.toString()}");
      return fromJson({
        "success": false,
        "message": "Unexpected error",
        "data": null,
        "error": {"code": "UNKNOWN_ERROR", "details": e.toString()},
      });
    }
  }

  // ---------------- Public HTTP Methods ----------------
  Future<T> get<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic /*String?|Iterable<String>*/>? queryParameters,
  }) => _request(
    path,
    method: 'GET',
    fromJson: fromJson,
    queryParameters: queryParameters,
  );

  /// whether the [path] we have provided are complete one
  /// usefull to handle for different domain
  Future<T> post<T>(
    String path, {
    bool isCompletePath = false,
    dynamic body,
    Map<String, dynamic /*String?|Iterable<String>*/>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) => _request(
    path,
    fullPath: isCompletePath ? path : null,
    method: 'POST',
    body: body,
    fromJson: fromJson,
    queryParameters: queryParameters,
  );

  Future<T> put<T>(
    String path, {
    dynamic body,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic /*String?|Iterable<String>*/>? queryParameters,
  }) => _request(
    path,
    method: 'PUT',
    body: body,
    fromJson: fromJson,
    queryParameters: queryParameters,
  );

  Future<T> delete<T>(
    String path, {
    Map<String, dynamic /*String?|Iterable<String>*/>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) => _request(
    path,
    method: 'DELETE',
    fromJson: fromJson,
    queryParameters: queryParameters,
  );

  /// handles refresh  token
  Future<T> refreshToken<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    required String refreshToken,
  }) async {
    final uri = baseUri.replace(path: path);

    final response = await http.post(
      uri,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
      },
    );

    if (response.statusCode != 200) {
      throw HttpException('Failed to refresh token: ${response.statusCode}');
    }

    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    return fromJson(jsonMap);
  }
}
