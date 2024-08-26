// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChannelModel extends Equatable {
  final String userId;
  final String fullName;
  final String photoProfilePath;
  final String lastMassage;
  final DateTime lastTimeMessage;
  const ChannelModel({
    required this.userId,
    required this.fullName,
    this.photoProfilePath = '',
    required this.lastMassage,
    required this.lastTimeMessage,
  });

  @override
  List<Object> get props =>
      [userId, photoProfilePath, lastMassage, lastTimeMessage];
}
