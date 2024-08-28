import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketServices {
  final String userId;
  io.Socket? _socket;

  static SocketServices? _instance;

  factory SocketServices(userId) {
    _instance ??= SocketServices._internal(userId);
    return _instance!;
  }

  SocketServices._internal(this.userId) {
    if (_socket == null) {
      _socket = io.io(
        Env.baseEndpoint,
        <String, dynamic>{
          'transports': ['websocket'],
          'query': {'userId': userId}
        },
      );
      return;
    }

    _socket = _socket;
  }

  SocketServices.instance({required String id}) : userId = id;

  void getOnlineUsers(Function(List<String>) cb) {
    _socket!.on('getOnlineUsers', (data) {
      List<dynamic> rawData = data;
      List<String> toListString = rawData.map((el) => el.toString()).toList();
      cb(toListString);
    });
  }

  void getNewChat(Function(ChatModel) cb) {
    _socket!.on('newChat', (data) {
      Map<String, dynamic> chatData = data;
      ChatModel newChat = ChatModel(
        chatId: chatData['_id'],
        from: chatData['from'],
        to: chatData['to'],
        message: chatData['message'],
        createdAt: chatData['createdAt'],
        updatedAt: chatData['updatedAt'],
      );
      cb(newChat);
    });
  }

  void disconnect() {
    _socket!.disconnect();
  }
}
