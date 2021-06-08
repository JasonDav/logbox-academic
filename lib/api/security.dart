import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:logbox_academic/api/client.dart';
import 'package:logbox_academic/model/security.dart';

abstract class BaseApi {
  final client = HttpClient();
  static const BASE_URL = "http://10.0.2.2:8080/LogBoxLiteREST/api";
}

class SecurityApi extends BaseApi {

  static const LOGIN_PATH = "/v1/security/authenticate";

  Future<dynamic> authenticate(String username, String password) async {
    print('Calling auth');
    print(Uri.parse(BaseApi.BASE_URL + LOGIN_PATH));
    return client.post(Uri.parse(BaseApi.BASE_URL + LOGIN_PATH), body: jsonEncode(Credentials(username, password).toJson()))
    .then((response) => print('${response.statusCode} : ${response.body}'), onError: (error) => print(error));
  }

}