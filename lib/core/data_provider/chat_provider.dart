import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

class ChatProvider {
  static Future<http.Response> sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    Uri url = Uri.parse('${Env.baseEndpoint}/chat');
    final Map<String, String> data = {
      'from': from,
      'to': to,
      'message': message
    };
    http.Response response = await http.post(url,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    return response;
  }

  static Future<http.Response> getMessages({required String userId}) async {
    Uri url = Uri.parse('${Env.baseEndpoint}/chat/$userId');
    http.Response response = await http.get(url);
    return response;
  }
}
