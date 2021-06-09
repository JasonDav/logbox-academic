import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:logbox_academic/api/client.dart';
import 'package:logbox_academic/model/security.dart';


class SecurityApi {

  static const LOGIN_PATH = "/v1/security/authenticate";

  static Future<dynamic> authenticate(String username, String password) async {
    return HttpClient().post(LOGIN_PATH, body: Credentials(username, password))
    .then((response) => HttpClient().setAuthToken(response.body));
  }

}