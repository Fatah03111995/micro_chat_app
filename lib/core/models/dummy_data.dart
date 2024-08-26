import 'package:micro_chat_app/core/models/channel_model.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';

class Dummydata {
  static List<ChatModel> get chats => [
        ChatModel(
            chatId: 'a1111',
            from: 'fatah',
            to: 'ahmad',
            message: 'halooo',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()),
        ChatModel(
            chatId: 'a1111',
            from: 'fatah',
            to: 'ahmad',
            message: 'halooo',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()),
        ChatModel(
            chatId: 'a1111',
            from: 'fatah',
            to: 'ahmad',
            message: 'halooo',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now()),
      ];

  static List<ChannelModel> get channels => [
        ChannelModel(
          userId: '123',
          fullName: 'rizki adnan',
          lastMassage: 'hii let\'s out',
          lastTimeMessage: DateTime.now(),
        ),
        ChannelModel(
          userId: '123',
          fullName: 'ahmad fatihin',
          lastMassage: 'goo to gym',
          lastTimeMessage: DateTime.now(),
        )
      ];
}
