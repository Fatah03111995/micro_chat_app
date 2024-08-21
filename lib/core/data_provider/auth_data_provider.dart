import 'dart:convert';

import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final Map<String, String> data = {
      "email": email,
      "password": password,
    };
    final url = Uri.parse('${Env.baseEndpoint}/auth/login');
    print(url);
    final response = await http.post(url,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw body["message"] ?? 'error-login';
    }

    final Map<String, dynamic> body = jsonDecode(response.body);
    final Map<String, dynamic> bodyUser = body['user'];
    print(body);
    final String bodyToken = body['token'];
    final UserModel user = UserModel(
      userId: bodyUser['_id'],
      firstName: bodyUser['firstName'],
      lastName: bodyUser['lastName'],
      userName: bodyUser['userName'],
      email: bodyUser['email'],
      password: bodyUser['password'],
      userToken: bodyToken,
      fcmToken: bodyUser['fcmToken'],
      photoProfilePath: bodyUser['photoProfilePath'],
      status: bodyUser['status'],
    );
    return user;
  }
}
