// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:micro_chat_app/core/models/channel_model.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';

class ChatState extends Equatable {
  final List<String> onlineUser;
  final List<ChatModel> chats;
  final List<ChannelModel> channel;
  const ChatState({
    this.onlineUser = const [],
    this.chats = const [],
    this.channel = const [],
  });

  @override
  List<Object?> get props => [onlineUser, chats, channel];

  ChatState copyWith({
    List<String>? onlineUser,
    List<ChatModel>? chats,
    List<ChannelModel>? channel,
  }) {
    return ChatState(
      onlineUser: onlineUser ?? this.onlineUser,
      chats: chats ?? this.chats,
      channel: channel ?? this.channel,
    );
  }
}
