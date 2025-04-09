import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(22),
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Text('this is a message', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
