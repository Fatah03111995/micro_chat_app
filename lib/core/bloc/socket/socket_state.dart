// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:micro_chat_app/core/services/socket_services.dart';

class SocketState extends Equatable {
  const SocketState();

  @override
  List<Object?> get props => [];
}

class SocketStateConnected extends SocketState {
  final SocketServices socketServices;

  const SocketStateConnected({required this.socketServices});

  @override
  List<Object?> get props => [socketServices];
}

class SocketStateDisconnected extends SocketState {}
