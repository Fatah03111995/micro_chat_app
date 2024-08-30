import 'dart:convert';

import 'package:micro_chat_app/core/data_provider/chat_provider.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/util/util_component.dart';

class ChatRepositories {
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
