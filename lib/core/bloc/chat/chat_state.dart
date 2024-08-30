// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:micro_chat_app/core/models/chat_model.dart';

class ChatState extends Equatable {
  final List<String> onlineUser;
  final List<ChatModel> chats;
  const ChatState({this.chats = const [], this.onlineUser = const []});

  @override
  List<Object?> get props => [onlineUser, chats];

  ChatState copyWith({
    List<String>? onlineUser,
    List<ChatModel>? chats,
  }) {
    return ChatState(
      onlineUser: onlineUser ?? this.onlineUser,
      chats: chats ?? this.chats,
    );
  }
}
