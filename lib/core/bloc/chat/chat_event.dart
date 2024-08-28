import 'package:micro_chat_app/core/models/chat_model.dart';

class ChatEvent {
  const ChatEvent();
}

class NewChat extends ChatEvent {
  final ChatModel chat;

  const NewChat({required this.chat});
}

class NewOnlineUsers extends ChatEvent {
  final List<String> newOnline;
  const NewOnlineUsers({required this.newOnline});
}
