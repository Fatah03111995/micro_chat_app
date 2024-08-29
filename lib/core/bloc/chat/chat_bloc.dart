import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<NewChat>(_onNewChatHandler);
    on<NewOnlineUsers>(_onNewOnlineUsers);
  }

  _onNewChatHandler(NewChat event, Emitter emit) {
    final List<ChatModel> chats = state.chats;
    final ChatModel newChat = event.chat;
    bool isNew = chats.any((chat) => chat.chatId == newChat.chatId);
    if (isNew) {
      state.chats.add(newChat);
    }
    emit(state.copyWith(chats: chats));
  }

  _onNewOnlineUsers(NewOnlineUsers event, Emitter emit) {
    emit(state.copyWith(onlineUser: event.newOnline));
  }
}
