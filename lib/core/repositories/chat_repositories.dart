import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/chat_provider.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class ChatRepositories {
  static Future<ChatModel> sendMessage({
    required String from,
    required String to,
    required String message,
  }) async {
    try {
      final response =
          await ChatProvider.sendMessage(from: from, to: to, message: message);
      final body = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw body['message'] ?? 'error sending data';
      }
      print(body);
      print(body.runtimeType);
      final rawData = body['newChat'] as Map<String, dynamic>;
      return ChatModel(
        chatId: rawData['_id'],
        from: rawData['from'],
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

  static Future<List<ChatModel>> getAllChat({required String userId}) async {
    try {
      final response = await ChatProvider.getMessages(userId: userId);
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
            from: el['from'],
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
