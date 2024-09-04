import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:micro_chat_app/core/themes/my_themes.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/core/util/app_date_time.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String? sender;
  final DateTime? dateTime;
  final bool isMe;
  final bool afterIsSameUser;
  final bool beforeIsSameUser;

  const ChatBubble(
      {super.key,
      this.beforeIsSameUser = false,
      this.afterIsSameUser = false,
      this.sender,
      required this.text,
      this.dateTime,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (sender != null)
            Text(
              sender!,
              style: TextStyles.s,
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(20),
                  bottomRight: const Radius.circular(20),
                  topLeft: isMe
                      ? const Radius.circular(20)
                      : beforeIsSameUser
                          ? const Radius.circular(20)
                          : const Radius.circular(0),
                  topRight: isMe
                      ? beforeIsSameUser
                          ? const Radius.circular(20)
                          : const Radius.circular(0)
                      : const Radius.circular(20)),
              color: isMe ? Colors.blue[200] : Theme.of(context).containerColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(0, 2),
                    blurRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyles.sBold
                      .copyWith(color: Theme.of(context).textColor),
                ),
                if (dateTime != null) SizedBox(height: 5.h),
                if (dateTime != null)
                  Text(
                    afterIsSameUser
                        ? AppDateTime.toHourMinute(dateTime!)
                        : AppDateTime.toDateHourMinute(dateTime!),
                    style: TextStyles.s
                        .copyWith(color: Theme.of(context).textColor),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
