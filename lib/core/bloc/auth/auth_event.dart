// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String username;
  final String email;
  final String password;
  final String confimrPassword;
  const AuthEventRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.confimrPassword,
  });
}

class AuthEventLogOut extends AuthEvent {}
