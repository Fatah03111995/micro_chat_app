import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/services/socket_services.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SocketServices _socketServices;

  ChatBloc()
      : _socketServices = SocketServices(),
        super(const ChatState()) {
    on<Connect>(_onConnectEventHandler);
    on<LoadChat>(_onLoadChatHandler);
    on<Disconnect>(_onDisconnectEventHandler);
    on<NewChat>(_onNewChatEventHandler);
    on<NewOnlineUsers>(_onNewOnlineUsersEventHandler);
  }

  _onConnectEventHandler(Connect event, Emitter emit) {
    _socketServices.connect(userId: event.userId);
    _socketServices.getNewChat((newChat) {
      add(NewChat(newChat: newChat));
    });
    _socketServices.getOnlineUsers((newOnlineUser) {
      add(NewOnlineUsers(newOnline: newOnlineUser));
    });
  }

  _onLoadChatHandler(LoadChat event, Emitter emit) {
    emit(state.copyWith(chats: event.chats));
  }

  _onDisconnectEventHandler(Disconnect event, Emitter emit) {
    _socketServices.disconnect();
  }

  _onNewChatEventHandler(NewChat event, Emitter emit) {
    print('chat handler');
    final List<ChatModel> chats = [...state.chats];
    bool isNew = chats.any((chat) => chat.chatId == event.newChat.chatId);
    if (!isNew) {
      chats.add(event.newChat);
    }
    emit(state.copyWith(chats: chats));
  }

  _onNewOnlineUsersEventHandler(NewOnlineUsers event, Emitter emit) {
    emit(state.copyWith(onlineUser: event.newOnline));
  }
}
