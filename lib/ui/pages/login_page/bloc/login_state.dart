// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isPassNotVisible;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isPassNotVisible = true,
  });

  @override
  List<Object?> get props => [email, password, isPassNotVisible];

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPassNotVisible,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPassNotVisible: isPassNotVisible ?? this.isPassNotVisible,
    );
  }

  @override
  bool get stringify => true;
}
