import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logbox_academic/main.dart';

class HttpClient {

  static const BASE_URL = "http://10.0.2.2:8080/LogBoxLiteREST/api";

  /// The headers passed with every request to the server.
  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  /// See [Client] for additional methods.
  final http.Client _inner = http.Client();

  // REST Methods

  Future<Response> get(String path, { Map<String, String>? extraHeaders, Map<String, dynamic /*String|Iterable<String>*/ >? queryParameters }) async {
    Uri uri = Uri.parse(BASE_URL + path)..replace(queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String,String>() ..addAll(defaultHeaders);

    return _interceptResponse(_inner.get(uri, headers: headers));
  }

  Future<Response> delete(String path, { Map<String, String>? extraHeaders, Object? body, Map<String, dynamic /*String|Iterable<String>*/ >? queryParameters }) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String,String>() ..addAll(defaultHeaders);

    return _interceptResponse(_inner.delete(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Response> put(String path, { Map<String, String>? extraHeaders, Object? body, Map<String, dynamic /*String|Iterable<String>*/ >? queryParameters }) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String,String>() ..addAll(defaultHeaders);

    return _interceptResponse(_inner.put(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Response> patch(String path, { Map<String, String>? extraHeaders, Object? body, Map<String, dynamic /*String|Iterable<String>*/ >? queryParameters }) async {
    Uri uri = Uri(path: BASE_URL + path, queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String,String>() ..addAll(defaultHeaders);

    return _interceptResponse(_inner.patch(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Response> post(String path, { Map<String, String>? extraHeaders, Object? body, Map<String, dynamic /*String|Iterable<String>*/ >? queryParameters }) async {
    Uri uri = Uri.parse(BASE_URL + path)..replace(queryParameters: queryParameters);
    var headers = extraHeaders != null ? extraHeaders : Map<String,String>() ..addAll(defaultHeaders);
    
    return _interceptResponse(_inner.post(uri, headers: headers, body: jsonEncode(body)));
  }

  // Response Interceptors
  Future<Response> _interceptResponse(Future<Response> response) {
    return response.then((value) {

      if (value.statusCode == 200) {
        return value;
      }

      var msg = 'URL \"${value.request!.url.toString()}\" => Completed with error code: ${value.statusCode} with body: ${value.body}';

      /// Catch 401 errors and redirect to login
      if (value.statusCode == 401) {
        msg = 'Access denied - Redirecting to login...';
        MyApp.navigatorKey.currentState!.popAndPushNamed('/login');
      }
      else if (value.statusCode == 404) {
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