// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';

class ChannelModel extends Equatable {
  final String userEmail;
  final String fullName;
  final String photoProfilePath;
  final List<ChatModel> chats;
  const ChannelModel({
    required this.userEmail,
    required this.fullName,
    this.photoProfilePath = '',
    required this.chats,
  });

  @override
  List<Object> get props => [userEmail, fullName, photoProfilePath, chats];
}
