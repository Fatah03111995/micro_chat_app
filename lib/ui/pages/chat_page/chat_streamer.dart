import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/widget/chat_bubble.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class ChatStreamer extends StatelessWidget {
  final String friendId;
  const ChatStreamer({super.key, this.friendId = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 7,
        title: Column(
          children: [
            Row(
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
                        bool isOnline = onlinUser.contains(friendId);
                        return Text(
                          isOnline ? 'Online' : 'Offline',
                          style: TextStyles.s.copyWith(
                              color:
                                  isOnline ? MyColors.blue1 : Colors.black54),
                        );
                      },
                    )
                  ],
                ),
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
                  print('build');
                  print(chats);
                  return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        ChatModel chat = chats[index];
                        return ChatBubble(
                          sender: chat.from,
                          text: chat.message,
                          isMe: chat.from ==
                              context.read<UserCubit>().state.user!.userId,
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
                onChanged: (newValue) {},
                suffixIcon: const Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
