import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/models/chat_model.dart';
import 'package:micro_chat_app/core/models/dummyData.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/widget/chat_bubble.dart';
import 'package:micro_chat_app/ui/widget/input_text.dart';

class ChatStreamer extends StatelessWidget {
  const ChatStreamer({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = Dummydata.chats;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 7,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              child: Assets.person.image(),
            ),
            SizedBox(width: 10.w),
            Text(
              'ahmad',
              style: TextStyles.sm,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    ChatModel chat = chats[index];
                    return ChatBubble(
                      sender: chat.from,
                      text: chat.message,
                      isMe: false,
                      dateTime: chat.createdAt,
                    );
                  }),
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
