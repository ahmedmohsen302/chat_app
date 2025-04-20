import 'package:chat_app/models/message_model.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatSuccess extends ChatStates {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

class ChatFailure extends ChatStates {}
