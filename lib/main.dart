import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micro_chat_app/core/env/env.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
              onPressed: () async {
                const Map<String, String> data = {
                  "email": "fatah03111995@gmail.com",
                  "password": "'123456'"
                };
                Uri url = Uri.parse('${Env.baseEndpoint}/auth/login');
                final response = await http.post(url,
                    body: jsonEncode(data),
                    headers: {"Content-Type": "application/json"});
                final body = jsonDecode(response.body);
              },
              child: const Text('Hello World!')),
        ),
      ),
    );
  }
}
