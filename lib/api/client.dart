import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logbox_academic/main.dart';

class HttpClient {
  static const BASE_URL = "http://192.168.1.109:8080/LogBoxLiteREST/api";

  /// The headers passed with every request to the server.
  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /// See [Client] for additional methods.
  final http.Client _inner = http.Client();

  // REST Methods

  Future<JsonResponse> get(String path,
      {Map<String, String>? extraHeaders,
      Map<String, dynamic /*String|Iterable<String>*/ >?
          queryParameters}) async {
    Uri uri = Uri.parse(BASE_URL + path)
      ..replace(queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String, String>()
      ..addAll(defaultHeaders);

    return _interceptResponse(_inner.get(uri, headers: headers));
  }

  Future<JsonResponse> delete(String path,
      {Map<String, String>? extraHeaders,
      Object? body,
      Map<String, dynamic /*String|Iterable<String>*/ >?
          queryParameters}) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String, String>()
      ..addAll(defaultHeaders);

    return _interceptResponse(
        _inner.delete(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<JsonResponse> put(String path,
      {Map<String, String>? extraHeaders,
      Object? body,
      Map<String, dynamic /*String|Iterable<String>*/ >?
          queryParameters}) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String, String>()
      ..addAll(defaultHeaders);

    return _interceptResponse(
        _inner.put(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<JsonResponse> patch(String path,
      {Map<String, String>? extraHeaders,
      Object? body,
      Map<String, dynamic /*String|Iterable<String>*/ >?
          queryParameters}) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String, String>()
      ..addAll(defaultHeaders);

    return _interceptResponse(
        _inner.patch(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<JsonResponse> post(String path,
      {Map<String, String>? extraHeaders,
      Object? body,
      Map<String, dynamic /*String|Iterable<String>*/ >?
          queryParameters}) async {
    Uri uri = Uri.parse(BASE_URL + path)
      ..replace(queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String, String>()
      ..addAll(defaultHeaders);

    return _interceptResponse(
        _inner.post(uri, headers: headers, body: jsonEncode(body)));
  }

  // Response Interceptors
  Future<JsonResponse> _interceptResponse(Future<http.Response> response) {
    return response.then((value) {
      if (value.statusCode == 200) {
        return JsonResponse(value);
      }

      var msg =
          'URL \"${value.request!.url.toString()}\" => Completed with error code: ${value.statusCode} with body: ${value.body}';

      /// Catch 401 errors and redirect to login
      if (value.statusCode == 401) {
        msg = 'Access denied - Redirecting to login...';
        MyApp.navigatorKey.currentState!.popAndPushNamed('/login');
      } else if (value.statusCode == 404) {
        print('Got 404 response at \"${value.request!.url.toString()}\"');
      }

      throw HttpException(msg);
    });
  }

  /// Set the Authorization token after login
  setAuthToken(String token) {
    defaultHeaders['Authorization'] = 'Bearer $token';
  }

  // Singleton code
  static final HttpClient _singleton = HttpClient._internal();
  factory HttpClient() {
    return _singleton;
  }
  HttpClient._internal();
}

class JsonResponse {
  final Response response;

  JsonResponse(this.response);

  String get body => response.body;
  Uint8List get bodyBytes => response.bodyBytes;
  bool get isRedirect => response.isRedirect;
  String? get reasonPhrase => response.reasonPhrase;
  Map<String, String> get headers => response.headers;
  Map<String, dynamic> get json => jsonDecode(body);
}
