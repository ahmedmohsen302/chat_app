import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(data[kMessage], data['id'] ?? '');
  }
}
