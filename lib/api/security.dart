import 'dart:convert' show jsonDecode;

import 'package:logbox_academic/api/client.dart';
import 'package:logbox_academic/model/security.dart';
import 'package:logbox_academic/model/state.dart';
import 'package:logbox_academic/model/user.dart';

class SecurityApi {
  static const LOGIN_PATH = "/v1/security/authenticate";
  static const USER_PATH = "/v1/security/user";

  static Future<dynamic> authenticate(String username, String password) async {
    return HttpClient()
        .post(LOGIN_PATH, body: Credentials(username, password))
        .then((response) {
      var json = jsonDecode(response.body);
      HttpClient().setAuthToken(json['token']);
    });
  }

  static Future<User> fetchUser() async {
    return HttpClient().get(USER_PATH).then((response) {
      var user = User.fromJson(response.json);
      RootState().user = user;
      return user;
    });
  }
}
