import 'dart:convert';

import 'package:micro_chat_app/core/env/env.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final Map<String, String> data = {
      "email": email,
      "password": password,
    };
    final url = Uri.parse('${Env.baseEndpoint}/auth/login');
    final response = await http.post(url,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    return response;
  }
}
