import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/models/channel_model.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/services/io_socket_services.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? userEmail;
  final IOSocketServices _socketServices;

  ChatBloc({this.userEmail})
      : _socketServices = IOSocketServices(),
        super(const ChatState()) {
    IOSocketServices();
    on<Connect>(_onConnectEventHandler);
    on<LoadChat>(_onLoadChatHandler);
    on<Disconnect>(_onDisconnectEventHandler);
    on<NewChat>(_onNewChatEventHandler);
    on<NewOnlineUsers>(_onNewOnlineUsersEventHandler);
    on<Channeling>(_onChannelingEventHandlet);
  }

  _onConnectEventHandler(Connect event, Emitter emit) {
    _socketServices.connect(userEmail: event.userEmail);
    _socketServices.getNewChat((newChat) {
      add(NewChat(newChat: newChat));
      if (userEmail != null) {
        add(Channeling(userEmail: userEmail!));
      }
    });
    _socketServices.getOnlineUsers((newOnlineUser) {
      add(NewOnlineUsers(newOnline: newOnlineUser));
    });
  }

  _onLoadChatHandler(LoadChat event, Emitter emit) {
    emit(state.copyWith(chats: event.chats));
    if (userEmail != null) {
      add(Channeling(userEmail: userEmail!));
    }
  }

  _onDisconnectEventHandler(Disconnect event, Emitter emit) {
    _socketServices.disconnect();
  }

  _onNewChatEventHandler(NewChat event, Emitter emit) {
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

  _onChannelingEventHandlet(Channeling event, Emitter emit) {
    List<ChannelModel> channel = _channeling(state.chats, event.userEmail);
    emit(state.copyWith(channel: channel));
  }

  List<ChannelModel> _channeling(List<ChatModel> chats, String userEmail) {
    Set<String> setUserFriends = {};
    List<ChannelModel> channels = [];

    for (final chat in chats) {
      if (chat.from != userEmail) {
        setUserFriends.add(chat.from);
      }
      if (chat.to != userEmail) {
        setUserFriends.add(chat.to);
      }
    }

    if (setUserFriends.isNotEmpty) {
      for (final userFriend in setUserFriends) {
        String friendFullName = '';
        String friendPhotoUrl = '';
        List<ChatModel> friendChats = [
          ...chats.where((chat) {
            if (chat.from != userEmail) {
              friendFullName = chat.fromFullName;
              friendPhotoUrl = chat.fromPhotoUrl;
            }
            if (chat.to != userEmail) {
              friendFullName = chat.toFullName;
              friendPhotoUrl = chat.toPhotoUrl;
            }

            return (chat.from == userFriend && chat.to == userEmail) ||
                (chat.from == userEmail && chat.to == userFriend);
          })
        ];

        friendChats.sort((a, b) => a.createdAt.compareTo(b.createdAt));

        channels.add(ChannelModel(
            userEmail: userFriend,
            fullName: friendFullName,
            chats: friendChats,
            photoProfilePath: friendPhotoUrl));
      }
      return channels;
    }
    return channels;
  }
}
