// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final File? photoProfilePath;
  final bool isPassNotVisible;
  final bool isConfirmPassNotVisible;

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.photoProfilePath,
    this.isPassNotVisible = true,
    this.isConfirmPassNotVisible = true,
  });

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      username,
      email,
      password,
      confirmPassword,
      photoProfilePath,
      isPassNotVisible,
      isConfirmPassNotVisible,
    ];
  }

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    File? photoProfilePath,
    bool? isPassNotVisible,
    bool? isConfirmPassNotVisible,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      photoProfilePath: photoProfilePath ?? this.photoProfilePath,
      isPassNotVisible: isPassNotVisible ?? this.isPassNotVisible,
      isConfirmPassNotVisible:
          isConfirmPassNotVisible ?? this.isConfirmPassNotVisible,
    );
  }

  @override
  bool get stringify => true;
}
