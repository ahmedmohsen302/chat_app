import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = 'chatView';
  final controler = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
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
      body: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controler,
                    itemCount: messageList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(message: messageList[index])
                          : FriendChatBuble(message: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        kMessage: value,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      controler.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'send a message',
                      suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                      border: OutlineInputBorder(
                        gapPadding: 16,
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
