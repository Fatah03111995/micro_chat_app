import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_bloc.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_event.dart';
import 'package:micro_chat_app/core/bloc/chat/chat_state.dart';
import 'package:micro_chat_app/core/bloc/user/user_cubit.dart';
import 'package:micro_chat_app/core/models/channel_model.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/repositories/chat_repositories.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/chat_streamer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = context.read<UserCubit>().state.user!.email;
    context.read<ChatBloc>().add(Connect(userEmail: userEmail));
    context.read<ChatBloc>().userEmail = userEmail;

    return FutureBuilder(
      future: ChatRepositories.getAllChat(userEmail: userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          context.read<ChatBloc>().add(LoadChat(chats: snapshot.data!));
        }

        return BlocSelector<ChatBloc, ChatState, List<ChatModel>>(
          selector: (state) {
            return state.chats;
          },
          builder: (context, listChats) {
            return BlocSelector<ChatBloc, ChatState, List<ChannelModel>>(
              selector: (state) {
                return state.channel;
              },
              builder: (context, channels) {
                if (channels.isEmpty) {
                  return Center(
                    child: Text(
                      'There is no data here',
                      style: TextStyles.m,
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      final channel = channels[index];
                      final formatDate = DateFormat.jm().format;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChatStreamer()));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: channel.photoProfilePath.isEmpty
                                        ? Assets.person.image(fit: BoxFit.cover)
                                        : Assets.person
                                            .image(fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        channel.fullName,
                                        style: TextStyles.mBold,
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        channel.chats.last.message,
                                        style: TextStyles.sm,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                formatDate(channel.chats.last.createdAt),
                                style: TextStyles.sm,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            );
          },
        );
      },
    );
  }
}
