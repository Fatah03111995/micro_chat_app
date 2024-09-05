import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

class UserProvider {
  static Future<http.Response> getUserById(
      String userId, String userToken) async {
    ///[NEXT] --------------CHECK INTERNET CONNECTION FIRST, THROW ERROR IF THERE IS NO CONNECTION
    Uri url = Uri.parse('${Env.baseEndpoint}/user/$userId');
    final response = http.post(url, headers: {
      'Authorization': userToken,
    });
    return response;
  }

  static Future<http.Response> getUserByList(
      List<String> listUsers, String userToken) async {
    ///[NEXT] --------------CHECK INTERNET CONNECTION FIRST, THROW ERROR IF THERE IS NO CONNECTION
    Uri url = Uri.parse('${Env.baseEndpoint}/user');
    final data = {'friends': listUsers};
    final response = await http.post(url, body: jsonEncode(data), headers: {
      'Authorization': userToken,
      'Content-Type': 'application/json'
    });
    return response;
  }
}
