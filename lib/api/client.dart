import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _inner.send(request);
  }

  // Singleton code
  static final HttpClient _singleton = HttpClient._internal();
  factory HttpClient() {
    return _singleton;
  }
  HttpClient._internal();
  // Singleton code
}