import 'package:chat_app/models/message_model.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatSuccess extends ChatStates {
  List<MessageModel> messages;

  ChatSuccess({required this.messages});
}

class ChatFailure extends ChatStates {}
