import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

class ChatProvider {
  static Future<http.Response> sendMessage(
      {required String from,
      required String to,
      required String message,
      required String userToken}) async {
    ///[NEXT] --------------CHECK INTERNET CONNECTION FIRST, THROW ERROR IF THERE IS NO CONNECTION
    Uri url = Uri.parse('${Env.baseEndpoint}/chat');
    final Map<String, String> data = {
      'from': from,
      'to': to,
      'message': message
    };
    http.Response response = await http.post(url,
        body: jsonEncode(data),
        headers: {
          'Authorization': userToken,
          "Content-Type": "application/json"
        });
    return response;
  }

  static Future<http.Response> getMessages(
      {required String userEmail, required String userToken}) async {
    ///[NEXT] --------------CHECK INTERNET CONNECTION FIRST, THROW ERROR IF THERE IS NO CONNECTION
    Uri url = Uri.parse('${Env.baseEndpoint}/chat/$userEmail');
    http.Response response = await http.get(url, headers: {
      'Authorization': userToken,
    });
    return response;
  }
}
