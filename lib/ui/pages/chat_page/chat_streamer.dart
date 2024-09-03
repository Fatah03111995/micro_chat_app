import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/repositories/chat_repositories.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/widget/chat_bubble.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class ChatStreamer extends StatefulWidget {
  final String friendId;
  const ChatStreamer({super.key, this.friendId = ''});

  @override
  State<ChatStreamer> createState() => _ChatStreamerState();
}

class _ChatStreamerState extends State<ChatStreamer> {
  final TextEditingController message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 7,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              child: Assets.person.image(),
            ),
            SizedBox(width: 10.w),
            Column(
              children: [
                Text(
                  'ahmad',
                  style: TextStyles.sm,
                ),
                SizedBox(height: 5.h),
                BlocSelector<ChatBloc, ChatState, List<String>>(
                  selector: (state) {
                    return state.onlineUser;
                  },
                  builder: (context, onlinUser) {
                    bool isOnline = onlinUser.contains(widget.friendId);
                    return Text(
                      isOnline ? 'Online' : 'Offline',
                      style: TextStyles.s.copyWith(
                          color: isOnline ? MyColors.blue1 : Colors.black54),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: BlocSelector<ChatBloc, ChatState, List<ChatModel>>(
                selector: (state) {
                  return state.chats;
                },
                builder: (context, chats) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom);
                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        int? indexBefore = index == 0 ? null : index - 1;
                        int? indexAfter =
                            chats.length - 1 == index ? null : index + 1;
                        ChatModel chat = chats[index];

                        return ChatBubble(
                          beforeIsSameUser: indexBefore == null
                              ? false
                              : chat.from == chats[indexBefore].from,
                          afterIsSameUser: indexAfter == null
                              ? false
                              : chat.from == chats[indexAfter].from,
                          text: chat.message,
                          isMe: chat.from ==
                              context.read<UserCubit>().state.user!.email,
                          dateTime: chat.createdAt,
                        );
                      });
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: const BoxDecoration(color: Colors.white),
              child: InputText(
                hint: 'your messages...',
                controller: message,
                onChanged: (newValue) {},
                suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      String userEmail =
                          context.read<UserCubit>().state.user!.email;
                      final response = await ChatRepositories.sendMessage(
                          from: userEmail,
                          to: 'fatihin@gmail.com',
                          message: message.text);
                      if (context.mounted) {
                        context
                            .read<ChatBloc>()
                            .add(NewChat(newChat: response));
                      }
                      message.clear();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
