import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/auth_data_provider.dart';
import 'package:micro_chat_app/core/exception/auth_exception.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

abstract class AuthRepositories {
  Future<UserModel> logIn(String email, String password);
  Future<UserModel> register();
  void logOut();
}

class ExpressAuth implements AuthRepositories {
  @override
  Future<UserModel> register() {
    // TODO: implement register
    throw UnimplementedError();
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

  @override
  void logOut() {
    // TODO: implement signOut
  }
}
