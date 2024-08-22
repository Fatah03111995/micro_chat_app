import 'dart:convert';
import 'dart:io';

import 'package:micro_chat_app/core/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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

  static Future<http.StreamedResponse> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String fcmToken,
    required File photoProfilePath,
  }) async {
    final url = Uri.parse('${Env.baseEndpoint}/auth/register');
    final request = http.MultipartRequest('POST', url);
    request.files.add(http.MultipartFile(
        'picture',
        http.ByteStream(photoProfilePath.openRead()),
        await photoProfilePath.length(),
        filename: path.basename(photoProfilePath.path)));

    request.fields["firstName"] = firstName;
    request.fields["lastName"] = lastName;
    request.fields["userName"] = userName;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["fcmToken"] = fcmToken;

    final response = await request.send();
    print(response.toString());
    return response;
  }
}
