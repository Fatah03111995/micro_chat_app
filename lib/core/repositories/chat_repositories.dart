import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/chat_provider.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class ChatRepositories {
  static Future<ChatModel> sendMessage(
      {required String from,
      required String to,
      required String message,
      required String userToken}) async {
    try {
      final response = await ChatProvider.sendMessage(
          from: from, to: to, message: message, userToken: userToken);
      final body = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw body['message'] ?? 'error sending data';
      }
      final rawData = body as Map<String, dynamic>;
      return ChatModel(
        chatId: rawData['_id'],
        fromUser: UserModel(
            userId: rawData['senderDetails']['_id'],
            firstName: rawData['senderDetails']['firstName'],
            lastName: rawData['senderDetails']['lastName'],
            userName: rawData['senderDetails']['userName'],
            email: rawData['senderDetails']['email'],
            fcmToken: rawData['senderDetails']['fcmToken'],
            photoProfilePath: rawData['senderDetails']['photoProfilePath']),
        from: rawData['from'],
        toUser: UserModel(
            userId: rawData['receiverDetails']['_id'],
            firstName: rawData['receiverDetails']['firstName'],
            lastName: rawData['receiverDetails']['lastName'],
            userName: rawData['receiverDetails']['userName'],
            email: rawData['receiverDetails']['email'],
            fcmToken: rawData['receiverDetails']['fcmToken'],
            photoProfilePath: rawData['receiverDetails']['photoProfilePath']),
        to: rawData['to'],
        message: rawData['message'],
        createdAt: DateTime.parse(rawData['createdAt'] as String),
        updatedAt: DateTime.parse(rawData['updatedAt'] as String),
      );
    } catch (e) {
      UtilComponent.toastErr(e.toString());
    }
    throw 'error on sending message';
  }

  static Future<List<ChatModel>> getAllChat(
      {required String userEmail, required String userToken}) async {
    try {
      final response = await ChatProvider.getMessages(
          userEmail: userEmail, userToken: userToken);
      final body = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw body['message'] ?? 'error load chat data';
      }
      List<ChatModel> chats = [];
      if (body.length != 0) {
        final List<dynamic> rawData = body;
        final List<Map<String, dynamic>> dataBody =
            rawData.map((el) => el as Map<String, dynamic>).toList();
        chats = dataBody.map((el) {
          return ChatModel(
            chatId: el['_id'],
            fromUser: UserModel(
                userId: el['senderDetails']['_id'],
                firstName: el['senderDetails']['firstName'],
                lastName: el['senderDetails']['lastName'],
                userName: el['senderDetails']['userName'],
                email: el['senderDetails']['email'],
                fcmToken: el['senderDetails']['fcmToken'],
                photoProfilePath: el['senderDetails']['photoProfilePath']),
            from: el['from'],
            toUser: UserModel(
                userId: el['receiverDetails']['_id'],
                firstName: el['receiverDetails']['firstName'],
                lastName: el['receiverDetails']['lastName'],
                userName: el['receiverDetails']['userName'],
                email: el['receiverDetails']['email'],
                fcmToken: el['receiverDetails']['fcmToken'],
                photoProfilePath: el['receiverDetails']['photoProfilePath']),
            to: el['to'],
            message: el['message'],
            createdAt: DateTime.parse(el['createdAt'] as String),
            updatedAt: DateTime.parse(el['updatedAt'] as String),
          );
        }).toList();
      }

      return chats;
    } catch (e) {
      UtilComponent.toastErr(e.toString());
    }
    throw 'error Load Data';
  }
}
