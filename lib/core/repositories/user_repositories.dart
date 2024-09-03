import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/user_provider.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class UserRepositories {
  static Future<UserModel> getUserById(String userId) async {
    try {
      final response = await UserProvider.getUserById(userId);
      final body = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw body['message'];
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
    } catch (e) {
      UtilComponent.toastErr(e.toString());
    }
    throw 'error getting use by id';
  }

  static Future<List<UserModel>> getUserByList(List<String> listUsers) async {
    try {
      final response = await UserProvider.getUserByList(listUsers);
      final body = jsonDecode(response.body);
      final List<UserModel> listData = [];

      if (response.statusCode != 200) {
        throw body['message'];
      }

      if (body.isNotEmpty) {
        final List<dynamic> rawBody = body;
        final List<Map<String, dynamic>> listRawData =
            rawBody.map((el) => el as Map<String, dynamic>).toList();

        for (final rawData in listRawData) {
          final List<dynamic> rawUserFriends = rawData['userFriends'] ?? [];
          final UserModel user = UserModel(
            userId: rawData['_id'],
            firstName: rawData['firstName'],
            lastName: rawData['lastName'],
            userName: rawData['userName'],
            email: rawData['email'],
            fcmToken: rawData['fcmToken'],
            photoProfilePath: rawData['photoProfilePath'],
            friends: rawUserFriends.map((el) => el.toString()).toList(),
          );
          listData.add(user);
        }
        return listData;
      }
    } catch (e) {
      UtilComponent.toastErr(e.toString());
    }
    throw 'error getting list user';
  }
}
