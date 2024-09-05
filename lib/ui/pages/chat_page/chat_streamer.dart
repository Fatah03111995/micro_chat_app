import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/env/env.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/models/user_model.dart';
import 'package:micro_chat_app/core/repositories/chat_repositories.dart';
import 'package:micro_chat_app/core/themes/my_colors.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/widget/chat_bubble.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class ChatStreamer extends StatefulWidget {
  final UserModel? friend;
  const ChatStreamer({super.key, this.friend});

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
    String userEmail = context.read<UserCubit>().state.user!.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBgColor,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: widget.friend!.photoProfilePath.isEmpty
                  ? Assets.person.image(fit: BoxFit.cover)
                  : Image.network(
                      '${Env.baseEndpoint}${widget.friend!.photoProfilePath}',
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.friend!.firstName} ${widget.friend!.lastName}',
                  style: TextStyles.sm
                      .copyWith(color: Theme.of(context).textColor),
                ),
                SizedBox(height: 5.h),
                BlocSelector<ChatBloc, ChatState, List<String>>(
                  selector: (state) {
                    return state.onlineUser;
                  },
                  builder: (context, onlinUser) {
                    bool isOnline = onlinUser.contains(widget.friend!.email);
                    return Text(
                      isOnline ? 'Online' : 'Offline',
                      style: TextStyles.s.copyWith(
                          color: isOnline
                              ? MyColors.blue1
                              : Theme.of(context).textColor),
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
                builder: (context, listChats) {
                  List<ChatModel> chats = listChats.where((chat) {
                    return (chat.from == widget.friend!.email &&
                            chat.to == userEmail) ||
                        (chat.from == userEmail &&
                            chat.to == widget.friend!.email);
                  }).toList();

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
              child: InputText(
                hint: 'your messages...',
                controller: message,
                onChanged: (newValue) {},
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).textColor,
                    ),
                    onPressed: () async {
                      final response = await ChatRepositories.sendMessage(
                          from: userEmail,
                          to: widget.friend!.email,
                          message: message.text,
                          userToken:
                              context.read<UserCubit>().state.user!.userToken);
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
