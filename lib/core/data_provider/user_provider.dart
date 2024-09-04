import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

class UserProvider {
  static Future<http.Response> getUserById(
      String userId, String userToken) async {
    Uri url = Uri.parse('${Env.baseEndpoint}/user/$userId');
    final response = http.post(url, headers: {
      'Authorization': userToken,
    });
    return response;
  }

  static Future<http.Response> getUserByList(
      List<String> listUsers, String userToken) {
    Uri url = Uri.parse('${Env.baseEndpoint}/user');
    final data = {'friends': listUsers};
    final response = http.post(url, body: jsonEncode(data), headers: {
      'Authorization': userToken,
      'Content-Type': 'application/json'
    });
    return response;
  }
}
