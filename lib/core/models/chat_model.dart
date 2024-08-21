// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String chatId;
  final String from;
  final String to;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  ChatModel({
    required this.chatId,
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        chatId,
        from,
        to,
        message,
        createdAt,
        updatedAt,
      ];
}
