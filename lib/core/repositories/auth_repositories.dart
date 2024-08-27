import 'dart:convert';
import 'dart:io';

import 'package:micro_chat_app/core/data_provider/auth_data_provider.dart';
import 'package:micro_chat_app/core/exception/auth_exception.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

abstract class AuthRepositories {
  Future<UserModel> logIn(String email, String password);
  Future<void> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String fcmToken,
    required File photoProfilePath,
  });
}

class ExpressAuth implements AuthRepositories {
  @override
  Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String fcmToken,
    required File photoProfilePath,
  }) async {
    final response = await AuthDataProvider.register(
      firstName: firstName,
      lastName: lastName,
      userName: userName,
      email: email,
      password: password,
      fcmToken: fcmToken,
      photoProfilePath: photoProfilePath,
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw AuthException(message: body["message"]);
    }

    return body;
  }

  @override
  Future<UserModel> logIn(String email, String password) async {
    final response =
        await AuthDataProvider.login(email: email, password: password);
    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw AuthException(message: body["message"]);
    }

    final Map<String, dynamic> bodyUser = body['user'];
    final String bodyToken = body['token'];
    final List<dynamic> friends = bodyUser['listFriend'];
    List<String> userFriends = [];
    if (friends.isNotEmpty) {
      userFriends = friends.map((el) => el.toString()).toList();
    }
    final UserModel user = UserModel(
      userId: bodyUser['_id'],
      firstName: bodyUser['firstName'],
      lastName: bodyUser['lastName'],
      userName: bodyUser['userName'],
      email: bodyUser['email'],
      userToken: bodyToken,
      fcmToken: bodyUser['fcmToken'],
      photoProfilePath: bodyUser['photoProfilePath'],
      friends: userFriends,
    );
    return user;
  }
}
