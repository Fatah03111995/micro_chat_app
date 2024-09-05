import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/user_provider.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class UserRepositories {
  static Future<UserModel> getUserById(String userId, String userToken) async {
    try {
      final response = await UserProvider.getUserById(userId, userToken);
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

  //----------------------YOU CAN REQUEST USER IN LIST(EX. LIST FRIEND, LIST SEARCH PERSON)
  static Future<List<UserModel>> getUserByList(
      List<String> listUsers, String userToken) async {
    try {
      final response = await UserProvider.getUserByList(listUsers, userToken);
      final body = jsonDecode(response.body);
      final List<UserModel> listData = [];

      if (response.statusCode != 200) {
        throw body['message'];
      }

      if (body.isNotEmpty) {
        //---------------DATA THAT RECEIVE IN JSON, ALWAYS List<Dynamics> or Map<String, dynamic>
        final List<dynamic> rawBody = body;
        final List<Map<String, dynamic>> listRawData =
            rawBody.map((el) => el as Map<String, dynamic>).toList();

        //---------------LOOPING, CHANGE EVERY ITEM FROM Map<String, dynamic> to UserModel
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

        //--------------SUMMERIZE
        return listData;
      }
    } catch (e) {
      UtilComponent.toastErr(e.toString());
    }
    throw 'error getting list user';
  }
}
