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
  final List<String> friends;
  const UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.userToken,
    required this.fcmToken,
    required this.photoProfilePath,
    this.friends = const [],
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
        friends,
      ];

  UserModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? userToken,
    String? fcmToken,
    String? photoProfilePath,
    List<String>? friends,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      userToken: userToken ?? this.userToken,
      fcmToken: fcmToken ?? this.fcmToken,
      photoProfilePath: photoProfilePath ?? this.photoProfilePath,
      friends: friends ?? this.friends,
    );
  }
}
