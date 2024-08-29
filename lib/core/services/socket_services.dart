// ignore_for_file: avoid_print

import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketServices {
  io.Socket? _socket;

  static SocketServices? _instance;

  factory SocketServices() {
    _instance ??= SocketServices._();
    return _instance!;
  }

  SocketServices._();

  void connect({required String userId}) {
    print('Connecting to socket...');
    _socket = io.io(Env.baseEndpoint, <String, dynamic>{
      'transports': ['websocket'],
      'query': {'userId': userId}
    });

    // Pastikan untuk mendengarkan event connect
    _socket!.on('connect', (_) {
      print('Socket connected');
    });

    _socket!.on('connect_error', (error) {
      print('Connection error: $error');
    });

    _socket!.on('disconnect', (_) {
      print('Socket disconnected');
    });
  }

  void getTest() {
    _socket!.on('test', (data) {
      print(data);
    });
  }

  void getOnlineUsers(Function(List<String>) cb) {
    _socket!.on('getOnlineUsers', (data) {
      List<dynamic> rawData = data;
      List<String> toListString = rawData.map((el) => el.toString()).toList();
      cb(toListString);
    });
  }

  void getNewChat(Function(ChatModel) cb) {
    _socket!.on('newChat', (data) {
      print(data);
      print(data.runtimeType);
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
