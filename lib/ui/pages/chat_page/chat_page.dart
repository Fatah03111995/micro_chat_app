import 'package:flutter/material.dart';
import 'package:micro_chat_app/ui/pages/chat_page/widget/chat_streamer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatStreamer()));
          },
          child: Text('To Chat')),
    );
  }
}
