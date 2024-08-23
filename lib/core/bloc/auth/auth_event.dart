// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:micro_chat_app/core/repositories/auth_repositories.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventIntial extends AuthEvent {}

class AuthEventLogIn extends AuthEvent {
  final AuthRepositories authRepositories;
  final String email;
  final String password;
  const AuthEventLogIn({
    required this.authRepositories,
    required this.email,
    required this.password,
  });
}

class AuthEventRegister extends AuthEvent {
  final AuthRepositories authRepositories;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final String fcmToken;
  final File? photoProfilePath;
  const AuthEventRegister({
    required this.authRepositories,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.fcmToken,
    this.photoProfilePath,
  });
}

class AuthEventLogOut extends AuthEvent {}
