// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String userToken;
  final String fcmToken;
  final String photoProfilePath;
  final bool status;
  const UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.userToken,
    required this.fcmToken,
    required this.photoProfilePath,
    required this.status,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        userName,
        email,
        userToken,
        fcmToken,
        photoProfilePath,
        status,
      ];
}
