import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:micro_chat_app/core/models/channel_model.dart';
import 'package:micro_chat_app/core/models/dummy_data.dart';
import 'package:micro_chat_app/core/themes/text_styles.dart';
import 'package:micro_chat_app/ui/gen/assets.gen.dart';
import 'package:micro_chat_app/ui/pages/chat_page/chat_streamer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChannelModel> channels = Dummydata.channels;
    if (channels.isEmpty) {
      return Center(
        child: Text(
          'There is no chat here bro!',
          style: TextStyles.m,
        ),
      );
    }
    return ListView.builder(
        itemCount: channels.length,
        itemBuilder: (context, index) {
          final channel = channels[index];
          final formattedDate = DateFormat.jm().format(channel.lastTimeMessage);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatStreamer()));
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
                            : Assets.person.image(fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            channel.fullName,
                            style: TextStyles.mBold,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            channel.lastMassage,
                            style: TextStyles.sm,
                          )
                        ],
                      ),
                    ],
                  ),
                  Text(
                    formattedDate,
                    style: TextStyles.sm,
                  )
                ],
              ),
            ),
          );
        });
  }
}
