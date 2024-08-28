import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/socket/socket_state.dart';
import 'package:micro_chat_app/core/services/socket_services.dart';

class SocketCubit extends Cubit<SocketState> {
  SocketCubit() : super(SocketStateDisconnected());

  void connecting(String userId) {
    SocketServices socketServices = SocketServices(userId);
    emit(SocketStateConnected(socketServices: socketServices));
  }

  @override
  Future<void> close() {
    emit(SocketStateDisconnected());
    return super.close();
  }
}
