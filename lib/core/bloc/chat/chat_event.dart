import 'package:micro_chat_app/core/models/chat_model.dart';

class ChatEvent {
  const ChatEvent();
}

class Connect extends ChatEvent {
  final String userId;

  const Connect({required this.userId});
}

class Disconnect extends ChatEvent {}

class NewChat extends ChatEvent {
  final ChatModel newChat;

  const NewChat({required this.newChat});
}

class LoadChat extends ChatEvent {
  final List<ChatModel> chats;

  const LoadChat({required this.chats});
}

class NewOnlineUsers extends ChatEvent {
  final List<String> newOnline;
  const NewOnlineUsers({required this.newOnline});
}
