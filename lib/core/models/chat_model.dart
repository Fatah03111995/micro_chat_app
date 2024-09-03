// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String chatId;
  final String fromFullName;
  final String fromPhotoUrl;
  final String from;
  final String toFullName;
  final String toPhotoUrl;
  final String to;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ChatModel({
    this.toPhotoUrl = '',
    this.fromPhotoUrl = '',
    required this.chatId,
    required this.fromFullName,
    required this.from,
    required this.toFullName,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        chatId,
        fromFullName,
        from,
        toFullName,
        to,
        message,
        createdAt,
        updatedAt,
      ];
}
