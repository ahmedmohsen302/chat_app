import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_states.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = 'chatView';
  final controler = ScrollController();

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kImage, height: 50),
            Text(
              'Chat',
              style: TextStyle(color: Colors.white, fontFamily: 'Pacifico'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatStates>(
              builder: (context, state) {
                List<MessageModel> messageList =
                    BlocProvider.of<ChatCubit>(context).messageslist;
                return ListView.builder(
                  reverse: true,
                  controller: controler,
                  itemCount: messageList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? ChatBuble(message: messageList[index])
                        : FriendChatBuble(message: messageList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).addMessage(message: value, email: email);
                controller.clear();
                controler.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'send a message',
                suffixIcon: IconButton(
                  onPressed: () {
                    final messageText = controller.text;
                    if (messageText.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(
                        context,
                      ).addMessage(message: messageText, email: email);
                      controller.clear();
                      controler.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  icon: Icon(Icons.send),
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  gapPadding: 16,
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
