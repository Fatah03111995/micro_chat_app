// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateRegisterSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateSuccess extends AuthState {
  final UserModel user;
  final io.Socket socket;
  const AuthStateSuccess({required this.user, required this.socket});
  @override
  List<Object?> get props => [user];
}
