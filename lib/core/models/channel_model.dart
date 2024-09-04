// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

class ChannelModel extends Equatable {
  final UserModel user;
  final List<ChatModel> chats;
  const ChannelModel({
    required this.user,
    required this.chats,
  });

  @override
  List<Object> get props => [chats, user];
}
