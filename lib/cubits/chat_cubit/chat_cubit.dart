import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_states.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );
  List<MessageModel> messageslist = [];

  void addMessage({required String message, required String email}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messageslist.clear();
      for (var doc in event.docs) {
        messageslist.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageslist));
    });
  }
}
