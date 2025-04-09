import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(22),
        margin: EdgeInsets.only(left: 10, right: 5, top: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(22),
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class FriendChatBuble extends StatelessWidget {
  const FriendChatBuble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(22),
        margin: EdgeInsets.only(left: 10, right: 5, top: 10),
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
