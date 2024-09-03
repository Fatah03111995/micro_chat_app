import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

class UserProvider {
  static Future<http.Response> getUserById(String userId) async {
    Uri url = Uri.parse('${Env.baseEndpoint}/user/$userId');
    final response = http.post(url);
    return response;
  }

  static Future<http.Response> getUserByList(List<String> listUsers) {
    Uri url = Uri.parse('${Env.baseEndpoint}/user');
    final data = {'friends': listUsers};
    final response = http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    return response;
  }
}
