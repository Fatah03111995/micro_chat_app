// ignore_for_file: avoid_print

import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IOSocketServices {
  io.Socket? _socket;

  static IOSocketServices? _instance;

  factory IOSocketServices() {
    _instance ??= IOSocketServices._();
    return _instance!;
  }

  IOSocketServices._();

  void connect({required String userEmail}) {
    print('Connecting to socket...');
    _socket = io.io(
      Env.baseEndpoint,
      io.OptionBuilder().setTransports(['websocket']).setQuery(
          {'userEmail': userEmail}).build(),
    );

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
      Map<String, dynamic> chatData = data;
      ChatModel newChat = ChatModel(
        chatId: chatData['_id'],
        fromFullName:
            '${chatData['senderDetails']['firstName']} ${chatData['senderDetails']['lastName']}',
        from: chatData['from'],
        toFullName:
            '${chatData['receiverDetails']['firstName']} ${chatData['senderDetails']['lastName']}',
        to: chatData['to'],
        message: chatData['message'],
        createdAt: DateTime.parse(chatData['createdAt'] as String),
        updatedAt: DateTime.parse(chatData['updatedAt'] as String),
      );
      cb(newChat);
    });
  }

  void disconnect() {
    _socket!.disconnect();
  }
}
