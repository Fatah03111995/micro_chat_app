// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class UserModel {
  final String? userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String fcm;
  final File photoProfilePath;
  final bool status;
  UserModel(
    this.status, {
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.fcm,
    required this.photoProfilePath,
  });
}
