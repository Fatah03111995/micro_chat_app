// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/models/user_model.dart';

class ChatModel extends Equatable {
  final String chatId;
  final UserModel fromUser;
  final String from;
  final UserModel toUser;
  final String to;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatModel({
    required this.chatId,
    required this.fromUser,
    required this.from,
    required this.toUser,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        chatId,
        fromUser,
        from,
        toUser,
        to,
        message,
        createdAt,
        updatedAt,
      ];
}
